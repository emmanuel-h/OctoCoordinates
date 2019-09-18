local zone
local TimeSinceLastUpdate = 0
local function UpdateCoordinates(elapsed)
    if zone ~= GetRealZoneText() then
        zone = GetRealZoneText()
        SetMapToCurrentZone ()
    end
    TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
    if TimeSinceLastUpdate > .5 then
        TimeSinceLastUpdate = 0
        local posX, posY = GetPlayerMapPosition("player")
        local x = math.floor(posX * 10000)/100
        local y = math.floor(posY * 10000)/100
        OctoCoordinatesFontString:SetText("|c98FB98ff("..x..", "..y..")")
    end
    end

function OctoCoordinates_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
end
function OctoCoordinates_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" and ... == "OctoCoordinates" then
        self:UnregisteredEvent("ADDON_LOADED")
        OctoCoordinates:SetSize(100, 50)
        OctoCoordinates:SetPoint("TOP", "Minimap", "BOTTOM", 5, -5)
        OctoCoordinates:SetScript("OnUpdate", UpdateCoordinates)
        local coordsFont = OctoCoordinates:CreateFontString("OctoCoordinatesFontString", "ARTWORK", "GameFontNormal")
        coordsFont:SetPoint("CENTER", "OctoCoordinates", "CENTER", 0, 0)
        coordsFont:Show()
        OctoCoordinates:Show()
    end
end