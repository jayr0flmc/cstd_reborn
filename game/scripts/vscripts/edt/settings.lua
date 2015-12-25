-- Should the heroes automatically respawn on a time or stay dead until manully respawned
ENABLE_HERO_RESPAWN			= false
-- Should the main shop contain secret shop items as well as regular items
UNIVERSAL_SHOP_MODE			= false
-- Should we let people select the same hero as each other
ALLOW_SAME_HERO_SELECTION	= true

-- How long should we let people select their hero
HERO_SELECTION_TIME			= 0.0
-- How long after people select their heroes should the horn blow and the game start
PRE_GAME_TIME				= 30.0
-- How long should we let people look at the scoreboard before closing the server automatically
POST_GAME_TIME				= 60.0
-- How long should it take individual trees to respawn after being cut down/destroyed
TREE_REGROW_TIME			= 60.0

-- How much gold should players get per tick
GOLD_PER_TICK = 0
-- How long should we wait in seconds between gold ticks
GOLD_TICK_TIME = -1

-- Should we disable the recommened builds for heroes
RECOMMENDED_BUILDS_DISABLED = true
-- How far out should we allow the camera to go?  1134 is the default in Dota
CAMERA_DISTANCE_OVERRIDE = 1134.0

-- What icon size should we use for our heroes
MINIMAP_ICON_SIZE = 0.25
-- What icon size should we use for creeps
MINIMAP_CREEP_ICON_SIZE = 1.0
-- What icon size should we use for runes
MINIMAP_RUNE_ICON_SIZE = 1

-- -- How long in seconds should we wait between rune spawns
RUNE_SPAWN_TIME = 120
-- Should we use a custom buyback cost setting
CUSTOM_BUYBACK_COST_ENABLED = true
-- Should we use a custom buyback time
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true
-- Should we allow people to buyback when they die
BUYBACK_ENABLED = false

-- Should we disable fog of war entirely for both teams
DISABLE_FOG_OF_WAR_ENTIRELY = true
-- Should we give gold for hero kills the same as in Dota, or allow those values to be changed
USE_STANDARD_HERO_GOLD_BOUNTY = true

-- Should we have bots act like they would in Dota? (This requires 3 lanes, normal items, etc)
USE_STANDARD_DOTA_BOT_THINKING = false
-- Should we give gold for hero kills the same as in Dota, or allow those values to be changed?
USE_STANDARD_HERO_GOLD_BOUNTY = true

-- Should we do customized top bar values or use the default kill count per team
USE_CUSTOM_TOP_BAR_VALUES = true
-- Should we display the top bar score/count at all
TOP_BAR_VISIBLE = true
-- Should we display kills only on the top bar
-- (No denies, suicides, kills by neutrals)
-- Requires USE_CUSTOM_TOP_BAR_VALUES
SHOW_KILLS_ON_TOPBAR = true

-- Should we enable backdoor protection for our towers
ENABLE_TOWER_BACKDOOR_PROTECTION = false
-- Should we remove all illusions if the main hero dies
REMOVE_ILLUSIONS_ON_DEATH = false
-- Should we disable the gold sound when players get gold
DISABLE_GOLD_SOUNDS = false

-- Should the game end after a certain number of kills
END_GAME_ON_KILLS = true
-- How many kills for a team should signify an end of game
KILLS_TO_END_GAME_FOR_TEAM = 50

-- Should we allow heroes to have custom levels
USE_CUSTOM_HERO_LEVELS = true
-- What level should we let heroes get to
MAX_LEVEL = 50
-- Should we use custom XP values to level up heroes, or the default Dota numbers
USE_CUSTOM_XP_VALUES = true



-- Fill this table up with the required XP per level if you want to change it
XP_PER_LEVEL_TABLE = {}
for i = 1, MAX_LEVEL do
	XP_PER_LEVEL_TABLE[i] = (i - 1) * 100
end



-- Should we enable first blood for the first kill in this game?
ENABLE_FIRST_BLOOD = false
-- Should we hide the kill banners that show when a player is killed?
HIDE_KILL_BANNERS = false
-- Should we have players lose the normal amount of dota gold on death?
LOSE_GOLD_ON_DEATH = false
-- Should we only allow players to see their own inventory even when selecting other units?
SHOW_ONLY_PLAYER_INVENTORY = false
-- Should we prevent players from being able to buy items into their stash when not at a shop?
DISABLE_STASH_PURCHASING = false
-- Should we disable the announcer from working in the game?
DISABLE_ANNOUNCER = true
-- What hero should we force all players to spawn as? (e.g. "npc_dota_hero_axe").
-- Use nil to allow players to pick their own hero.
FORCE_PICKED_HERO = "npc_dota_hero_tinker"

-- What time should we use for a fixed respawn timer?
-- Use -1 to keep the default dota behavior.
FIXED_RESPAWN_TIME = -1
-- What should we use for the constant fountain mana regen?
-- Use -1 to keep the default dota behavior.
FOUNTAIN_CONSTANT_MANA_REGEN = -1
-- What should we use for the percentage fountain mana regen?
-- Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_MANA_REGEN = -1
-- What should we use for the percentage fountain health regen?
-- Use -1 to keep the default dota behavior.
FOUNTAIN_PERCENTAGE_HEALTH_REGEN = -1
-- What should we use for the maximum attack speed?
MAXIMUM_ATTACK_SPEED = 600
-- What should we use for the minimum attack speed?
MINIMUM_ATTACK_SPEED = 20


-- NOTE: You always need at least 2 non-bounty (non-regen while broken) type runes to be able to spawn or your game will crash!
-- Which runes should be enabled to spawn in our game mode?
ENABLED_RUNES = {}
ENABLED_RUNES[DOTA_RUNE_DOUBLEDAMAGE] = false
ENABLED_RUNES[DOTA_RUNE_HASTE] = false
ENABLED_RUNES[DOTA_RUNE_ILLUSION] = false
ENABLED_RUNES[DOTA_RUNE_INVISIBILITY] = false
-- Regen runes are currently not spawning as of the writing of this comment
ENABLED_RUNES[DOTA_RUNE_REGENERATION] = false
ENABLED_RUNES[DOTA_RUNE_BOUNTY] = false



-- How many potential teams can be in this game mode?
MAX_NUMBER_OF_TEAMS = 10
-- Should we use custom team colors?
USE_CUSTOM_TEAM_COLORS = true
-- Should we use custom team colors to color the players/minimap?
USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS = true

-- If USE_CUSTOM_TEAM_COLORS is set, use these colors.
TEAM_COLORS = {}
TEAM_COLORS[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }  --    Teal
TEAM_COLORS[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }   --    Yellow
TEAM_COLORS[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }  --    Pink
TEAM_COLORS[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }   --    Orange
TEAM_COLORS[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }   --    Blue
TEAM_COLORS[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }  --    Green
TEAM_COLORS[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }   --    Brown
TEAM_COLORS[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }  --    Cyan
TEAM_COLORS[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }  --    Olive
TEAM_COLORS[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }  --    Purple



-- Should we set the number of players to 10 / MAX_NUMBER_OF_TEAMS?
USE_AUTOMATIC_PLAYERS_PER_TEAM = false

-- If we're not automatically setting the number of players per team, use this table
CUSTOM_TEAM_PLAYER_COUNT = {}
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 8
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_6] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_7] = 0
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_8] = 0