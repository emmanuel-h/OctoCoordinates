local zone
local TimeSinceLastUpdate = 0

local function UpdateCoordinates(self, elapsed)
    local newZone = GetRealZoneText()
    local inInstance = IsInInstance()
    if zone ~= newZone then
        zone = newZone
        if inInstance then
            OctoCoordinatesFontString:SetText("|c00000000(--.--, --.--)")
            print("Disable OctoCoordinates, you are in the instance", zone)
        else
            print("Initialize OctoCoordinates for zone", zone)
        end
    end
    TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
    if TimeSinceLastUpdate > .5 and not inInstance then
        TimeSinceLastUpdate = 0
        local map = C_Map.GetBestMapForUnit("player")
        local position = C_Map.GetPlayerMapPosition(map, "player")
        local x = math.floor(position.x * 10000)/100
        local y = math.floor(position.y * 10000)/100
        OctoCoordinatesFontString:SetText("|c00000000("..x..", "..y..")")
    end
end

function OctoCoordinates_OnLoad(self, event, ...)
    self:RegisterEvent("ADDON_LOADED")
end

function OctoCoordinates_OnEvent(self, event, ...)
    if (event == "ADDON_LOADED" and ... == "OctoCoordinates") then
        print("OctoCoordinates loaded")
        self:UnregisterEvent("ADDON_LOADED")
        OctoCoordinates:SetSize(80, 25)
        OctoCoordinates:SetPoint("TOP", "Minimap", "BOTTOM", 5, -15)
        OctoCoordinates:SetScript("OnUpdate", UpdateCoordinates)
        OctoCoordinates:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 8,
            insets = { left = 1, right = 1, top = 1, bottom = 1 }
        })
        local coordsFont = OctoCoordinates:CreateFontString("OctoCoordinatesFontString", "OVERLAY", "GameFontBlackTiny")
        coordsFont:SetPoint("CENTER", "OctoCoordinates", "CENTER", 0, 0)
        coordsFont:Show()
        OctoCoordinates:Show()
    end
end