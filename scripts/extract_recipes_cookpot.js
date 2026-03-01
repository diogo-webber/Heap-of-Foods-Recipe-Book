const fs = require("fs")

const lua = fs.readFileSync("scripts/recipes_data/hof_foodrecipes.lua", "utf8")
const recipeRegex = /(\w+)\s*=\s*\{([\s\S]*?)\},/g
const recipes = []

const TEMPERATURE_DURATION_MAP = {
  FOOD_TEMP_BRIEF: 5,
  FOOD_TEMP_AVERAGE: 10,
  FOOD_TEMP_LONG: 15,
  BUFF_FOOD_TEMP_DURATION: 480,
}

const TEMPERATURE_VALUE_MAP = {
  HOT_FOOD_BONUS_TEMP: 40,
  COLD_FOOD_BONUS_TEMP: -40,
}

const PERISH_MAP = {
  PERISH_SUPERFAST: 1440,
  PERISH_FAST: 2880,
  PERISH_FASTISH: 3840,
  PERISH_MED: 4800,
  PERISH_SLOW: 7200,
  PERISH_PRESERVED: 9600,
  PERISH_SUPERSLOW: 19200,
}

function extractNumber(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([\\d\\.\\-]+)`))
  return match ? Number(match[1]) : null
}

function extractString(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([^,\\n]+)`))
  return match ? match[1].trim() : null
}

let match
while ((match = recipeRegex.exec(lua)) !== null) {
  const name = match[1]
  const block = match[2]

  if (
    !block.includes("foodtype") ||
    !block.includes("priority") ||
    !block.includes("health") ||
    !block.includes("hunger") ||
    !block.includes("sanity")
  ) {
    continue
  }

  const temperatureRaw = extractString(block, "temperature")
  const tempKey = temperatureRaw?.replace("TUNING.", "")
  const temperature =
    tempKey && TEMPERATURE_VALUE_MAP[tempKey] != null
      ? TEMPERATURE_VALUE_MAP[tempKey]
      : null

  const tempDurationKey =
    extractString(block, "temperatureduration")?.replace("TUNING.", "")
  const temperatureDuration =
    tempDurationKey && TEMPERATURE_DURATION_MAP[tempDurationKey] != null
      ? TEMPERATURE_DURATION_MAP[tempDurationKey]
      : null

  let spoilage = null
  let perishKeyRaw = extractString(block, "perishtime")?.replace("TUNING.", "")
  if (perishKeyRaw) {
    let perishValue = PERISH_MAP[perishKeyRaw] || Number(perishKeyRaw)

    if (perishValue > PERISH_MAP.PERISH_SUPERSLOW) {
      perishKeyRaw = "PERISH_SUPERSLOW"
      perishValue = PERISH_MAP[perishKeyRaw]
    }

    spoilage = perishValue
  }

  const debuff = block.includes("oneatenfn")

  recipes.push({
    name,
    priority: extractNumber(block, "priority"),
    foodtype:
      extractString(block, "foodtype")?.replace("FOODTYPE.", "") || null,
    spoilage,
    temperature,
    temperatureDuration,
    debuff,
    health: extractNumber(block, "health"),
    hunger: extractNumber(block, "hunger"),
    sanity: extractNumber(block, "sanity"),
    cooktime: extractNumber(block, "cooktime"),
    stacksize: extractNumber(block, "stacksize"),
  })
}

fs.writeFileSync(
  "data/recipes_cookpot.json",
  JSON.stringify(recipes, null, 2)
)

console.log("Recipes extracted successfully!")