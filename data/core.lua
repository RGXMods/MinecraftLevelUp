--=====================================================================================
-- MCLU | MinecraftLevelUp - core.lua
-- Version: 2.0.0
-- Author: DonnieDice
-- RGX Mods Collection - RealmGX Community Project
--=====================================================================================

local RGX = assert(_G.RGXFramework, "MCLU: RGX-Framework not loaded")

MCLU = MCLU or {}

local ADDON_VERSION = "2.0.4"
local ADDON_NAME = "MinecraftLevelUp"
local PREFIX = "|Tinterface/addons/MinecraftLevelUp/media/icon:16:16|t - |cffffffff[|r|cff629539MCLU|r|cffffffff]|r "
local TITLE = "|Tinterface/addons/MinecraftLevelUp/media/icon:18:18|t [|cff629539M|r|cffffffffinecraft|r |cff629539L|r|cffffffffevel|r |cff629539U|r|cff629539p|r|cff629539!|r]"

MCLU.version = ADDON_VERSION
MCLU.addonName = ADDON_NAME

local Sound = RGX:GetSound()

local handle = Sound:Register(ADDON_NAME, {
sounds = {
high = "Interface\\Addons\\MinecraftLevelUp\\sounds\\minecraft_high.ogg",
medium = "Interface\\Addons\\MinecraftLevelUp\\sounds\\minecraft_med.ogg",
low = "Interface\\Addons\\MinecraftLevelUp\\sounds\\minecraft_low.ogg",
},
defaultSoundId = 569593,
savedVar = "MCLUSettings",
defaults = {
enabled = true,
soundVariant = "medium",
muteDefault = true,
showWelcome = true,
volume = "Master",
firstRun = true,
},
triggerEvent = "PLAYER_LEVEL_UP",
addonVersion = ADDON_VERSION,
})

MCLU.handle = handle

local L = MCLU.L or {}
local initialized = false

local function ShowHelp()
print(PREFIX .. " " .. (L["HELP_HEADER"] or ""))
print(PREFIX .. " " .. (L["HELP_TEST"] or ""))
print(PREFIX .. " " .. (L["HELP_ENABLE"] or ""))
print(PREFIX .. " " .. (L["HELP_DISABLE"] or ""))
print(PREFIX .. " " .. (L["HELP_HIGH"] or ""))
print(PREFIX .. " " .. (L["HELP_MEDIUM"] or ""))
print(PREFIX .. " " .. (L["HELP_LOW"] or ""))
end

local function HandleSlashCommand(args)
local command = string.lower(args or "")
if command == "" or command == "help" then
ShowHelp()
elseif command == "test" then
print(PREFIX .. " " .. (L["PLAYING_TEST"] or ""))
handle:Test()
elseif command == "enable" then
handle:Enable()
print(PREFIX .. " " .. (L["ADDON_ENABLED"] or ""))
elseif command == "disable" then
handle:Disable()
print(PREFIX .. " " .. (L["ADDON_DISABLED"] or ""))
elseif command == "high" then
handle:SetVariant("high")
print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "high"))
elseif command == "med" or command == "medium" then
handle:SetVariant("medium")
print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "medium"))
elseif command == "low" then
handle:SetVariant("low")
print(PREFIX .. " " .. string.format(L["SOUND_VARIANT_SET"] or "%s", "low"))
else
print(PREFIX .. " " .. (L["ERROR_PREFIX"] or "") .. " " .. (L["ERROR_UNKNOWN_COMMAND"] or ""))
end
end

RGX:RegisterEvent("ADDON_LOADED", function(event, addonName)
if addonName ~= ADDON_NAME then return end
handle:SetLocale(MCLU.L)
L = MCLU.L or {}
handle:Init()
initialized = true
end, "MCLU_ADDON_LOADED")

RGX:RegisterEvent("PLAYER_LEVEL_UP", function()
if initialized then
handle:Play()
end
end, "MCLU_PLAYER_LEVEL_UP")

RGX:RegisterEvent("PLAYER_LOGIN", function()
if not initialized then
handle:SetLocale(MCLU.L)
L = MCLU.L or {}
handle:Init()
initialized = true
end
handle:ShowWelcome(PREFIX, TITLE)
end, "MCLU_PLAYER_LOGIN")

RGX:RegisterEvent("PLAYER_LOGOUT", function()
handle:Logout()
end, "MCLU_PLAYER_LOGOUT")

RGX:RegisterSlashCommand("mclu", function(msg)
local ok, err = pcall(HandleSlashCommand, msg)
if not ok then
print(PREFIX .. " " .. (L["ERROR_PREFIX"] or "") .. " " .. tostring(err))
end
end, "MCLU_SLASH")
