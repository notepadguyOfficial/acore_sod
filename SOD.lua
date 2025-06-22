local PLAYER_EVENT_ON_LOGIN = 3
local PLAYER_EVENT_ON_LEVEL_CHANGE = 13

local BUFFS = {
    { minLevel = 1,  maxLevel = 25, spellId = 80865 },  -- +50%
    { minLevel = 26, maxLevel = 40, spellId = 80866 },  -- +100%
    { minLevel = 41, maxLevel = 50, spellId = 80867 },  -- +150%
    { minLevel = 51, maxLevel = 60, spellId = 80868 },  -- +200%
    { minLevel = 61, maxLevel = 70, spellId = 80869 },  -- +250%
    { minLevel = 71, maxLevel = 80, spellId = 80870 },  -- +300%
}

-- Helper to log messages with player name
local function Log(player, message)
    print(string.format("[Discoverer's Delight] [%s] %s", player:GetName(), message))
end

-- Remove all buff variants
local function RemoveAllBuffs(player)
    for _, buff in ipairs(BUFFS) do
        if player:HasAura(buff.spellId) then
            player:RemoveAura(buff.spellId)
            Log(player, "Removed buff spell ID: " .. buff.spellId)
        end
    end
end

-- Hardcode this shit
local function RemoveAllAppliedBuffs(player)
	player:RemoveAura(80865)
	player:RemoveAura(80866)
	player:RemoveAura(80867)
	player:RemoveAura(80868)
	player:RemoveAura(80869)
	player:RemoveAura(80870)
end

-- Get correct buff based on level
local function GetBuffForLevel(level)
    for _, buff in ipairs(BUFFS) do
        if level >= buff.minLevel and level <= buff.maxLevel then
            return buff.spellId
        end
    end
    return nil
end

-- Apply the correct buff based on level
local function ApplyCorrectBuff(player)
    local level = player:GetLevel()
    local spellId = GetBuffForLevel(level)

    if not spellId then
        Log(player, "No valid buff found for level " .. level)
        return
    end

    RemoveAllBuffs(player)

    if not player:HasAura(spellId) then
        -- player:AddAura(spellId, player)
		player:CastSpell(player, spellId, true)
        Log(player, "Applied buff spell ID: " .. spellId .. " for level " .. level)
    else
        Log(player, "Buff spell ID " .. spellId .. " already active at level " .. level)
    end
end

-- Player login event
local function OnLogin(event, player)
    Log(player, "Player logged in at level " .. player:GetLevel())
	RemoveAllAppliedBuffs(player)
    ApplyCorrectBuff(player)
end

-- Player level-up event
local function OnLevelChanged(event, player, oldLevel)
    Log(player, "Level changed from " .. oldLevel .. " to " .. player:GetLevel())
    ApplyCorrectBuff(player)
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, OnLevelChanged)