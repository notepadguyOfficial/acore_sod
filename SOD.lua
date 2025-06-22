local BUFFS = {
    { minLevel = 1, maxLevel = 49, spellId = 200101 },  -- 200%
    { minLevel = 50, maxLevel = 59, spellId = 200102 }, -- 150%
    { minLevel = 60, maxLevel = 69, spellId = 200103 }, -- 100%
    { minLevel = 70, maxLevel = 80, spellId = 200104 }, -- 50%
}

local PLAYER_EVENT_ON_LOGIN = 3
local PLAYER_EVENT_ON_LEVEL_CHANGE = 13

-- Remove all possible Discoverer's Delight buffs
local function RemoveAllBuffs(player)
    for _, buff in ipairs(BUFFS) do
        if player:HasAura(buff.spellId) then
            player:RemoveAura(buff.spellId)
        end
    end
end

-- Get the appropriate buff for the given level
local function GetBuffForLevel(level)
    for _, buff in ipairs(BUFFS) do
        if level >= buff.minLevel and level <= buff.maxLevel then
            return buff.spellId
        end
    end
    return nil
end

-- Apply the correct buff to the player
local function ApplyCorrectBuff(player)
    local level = player:GetLevel()
    local spellId = GetBuffForLevel(level)
    if spellId then
        RemoveAllBuffs(player)
        player:AddAura(spellId, player)
    end
end

-- Event: Player logs in
local function OnLogin(event, player)
    ApplyCorrectBuff(player)
end

-- Event: Player levels up
local function OnLevelChanged(event, player, oldLevel)
    ApplyCorrectBuff(player)
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, OnLevelChanged)