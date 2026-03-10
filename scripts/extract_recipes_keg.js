const fs = require("fs")

const lua = fs.readFileSync("scripts/recipes_data/hof_brewrecipes_keg.lua", "utf8")

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

const BLOCKED_RECIPES = new Set([
  "kyno_foods_keg", // The actual table is being extracted...
])

const IGNORE_DEBUFF_RECIPES = new Set([
  "nukacola",
  "souljuice",
  "wine_durian",
  "juice_sporecap",
  "juice_sporecap_dark",
])

function extractNumber(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([\\d\\.\\-]+)`))
  return match ? Number(match[1]) : null
}

function extractString(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([^,\\n]+)`))
  return match ? match[1].trim() : null
}

function extractRecipesFromLua(luaText) {
  const results = []
  const nameRegex = /(\w+)\s*=\s*\{/g

  let match

  while ((match = nameRegex.exec(luaText)) !== null) {
    const name = match[1]
    let index = match.index + match[0].length
    let braceCount = 1

    while (braceCount > 0 && index < luaText.length) {
      if (luaText[index] === "{") braceCount++
      if (luaText[index] === "}") braceCount--
      index++
    }

    const block = luaText.slice(match.index, index)

    results.push({ name, block })
  }

  return results
}

const rawRecipes = extractRecipesFromLua(lua)

for (const recipe of rawRecipes) {
  const { name, block } = recipe

  if (BLOCKED_RECIPES.has(name)) {
    continue
  }

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

  const hasOneatenfn = /oneatenfn\s*=\s*function/.test(block)

  const debuff =
    hasOneatenfn && !IGNORE_DEBUFF_RECIPES.has(name)

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
  "data/recipes_cookpot_keg.json",
  JSON.stringify(recipes, null, 2)
)

console.log("Wooden Keg Recipes extracted successfully!")