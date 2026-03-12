const fs = require("fs")

const lua = fs.readFileSync("scripts/recipes_data/hof_foodrecipes.lua", "utf8")

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
  "kyno_foods", // The actual table is being extracted...
])

const IGNORE_DEBUFF_RECIPES = new Set([
  "soulstew",
  "hornocupia",
  "monstermuffin",
  "duriansplit",
  "duriansoup",
  "durianmeated",
  "durianchicken",
  "antslog",
  "purplewobstersoup",
  "wobstermonster",
  "spidercake",
  "lazypurrito",
])

function cleanIngredientName(name) {
  return name.replace(/^kyno_/, "")
}

function extractNumber(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([\\d\\.\\-]+)`))
  return match ? Number(match[1]) : null
}

function extractString(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*([^,\\n]+)`))
  return match ? match[1].trim() : null
}

function extractBoolean(block, key) {
  const match = block.match(new RegExp(`${key}\\s*=\\s*(true|false)`))
  return match ? match[1] === "true" : null
}

function extractCharacterFood(block) {
  const single = block.match(/characterfood\s*=\s*"(\w+)"/)
  if (single) return [single[1]]

  const multi = block.match(/characterfood\s*=\s*\{([^\}]+)\}/)
  if (multi) {
    return multi[1]
      .split(",")
      .map(s => s.replace(/["\s]/g, "").trim())
      .filter(Boolean)
  }

  return null
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

function extractItemBlocks(block, key) {
  const start = block.indexOf(key + " =")
  if (start === -1) return []

  let index = block.indexOf("{", start)
  if (index === -1) return []

  let braceCount = 1
  index++
  const startIndex = index - 1
  while (braceCount > 0 && index < block.length) {
    if (block[index] === "{") braceCount++
    if (block[index] === "}") braceCount--
    index++
  }
  
  const raw = block.slice(startIndex, index).trim()
  const itemBlocks = []
  const regex = /\{\s*items\s*=\s*\{([^\}]+)\}\s*(?:,\s*amount\s*=\s*(\d+))?\s*(?:,\s*comparator\s*=\s*"(\w+)")?\s*\}/g
  let m
  while ((m = regex.exec(raw)) !== null) {
    const items = m[1].split(",").map(s => s.replace(/["\s]/g,"").trim())
    const amount = m[2] ? Number(m[2]) : undefined
    const comparator = m[3] ? m[3] : "equal"
  
    const obj = { items }
    if (amount !== undefined) obj.amount = amount
    if (comparator) obj.comparator = comparator
    itemBlocks.push(obj)
  }
  return itemBlocks
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

  const characterfood = extractCharacterFood(block)

  const mermfood = extractBoolean(block, "mermfood")
  const monsterfood = extractBoolean(block, "monsterfood")

  const mermhealth = extractNumber(block, "mermhealth")
  const mermhunger = extractNumber(block, "mermhunger")
  const mermsanity = extractNumber(block, "mermsanity")

  const monsterhealth = extractNumber(block, "monsterhealth")
  const monstersanity = extractNumber(block, "monstersanity")

  const requires = extractItemBlocks(block, "required")
  const excluded = extractItemBlocks(block, "excluded")
  const card_def = extractItemBlocks(block, "card_def")

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

    characterfood,

    mermfood,
    mermhealth,
    mermhunger,
    mermsanity,

    monsterfood,
    monsterhealth,
    monstersanity,

    requires,
    excluded,
    card_def
  })
}

fs.writeFileSync(
  "data/recipes_cookpot.json",
  JSON.stringify(recipes, null, 2)
)

console.log("Recipes extracted successfully!")