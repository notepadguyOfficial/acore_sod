local PLAYER_EVENT_ON_LOGIN = 3

    -- 80865 +50%
    -- 80866 +100%
    -- 80867 +150%
    -- 80867 +150%
    -- 80868 +200%
    -- 80869 +250%
    -- 80870 +300%

-- Helper to log messages with player name
local function Log(player, message)
	print(string.format("[Discoverer's Delight] [%s] %s", player:GetName(), message))
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

-- Player login event
local function OnLogin(event, player)
	Log(player, "Player logged in at level " .. player:GetLevel())
	RemoveAllAppliedBuffs(player)
	player:CastSpell(player, 80870, true)
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
