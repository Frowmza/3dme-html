RegisterNetEvent("3dme:me")
AddEventHandler("3dme:me", function(text, source, icon)
    local playerId = GetPlayerFromServerId(source)
    local isDisplaying = true
    if icon == nil then icon = 'icons' end
    Citizen.CreateThread(function()
        while isDisplaying do
            Citizen.Wait(0)
            local htmlString = ""
            local sourceCoords = GetEntityCoords(GetPlayerPed(playerId))
            local nearCoords = GetEntityCoords(PlayerPedId())
            local distance = Vdist2(sourceCoords, nearCoords)
            if distance < 25.0 then
                local onScreen, xxx, yyy =
                    GetHudScreenPositionFromWorldPosition(
                        sourceCoords.x + Config.CoordsX,
                        sourceCoords.y + Config.CoordsY,
                        sourceCoords.z + Config.CoordsZ)
                htmlString =
                    htmlString ..
                    '<span style="position: absolute; left: ' ..
                    xxx * 100 ..
                    "%;top: " .. yyy * 100 .. '%;"><p class="box sb3"><i class="fas fa-'..icon..' fa-3x fa-pull-left"></i>' .. text .. "</p></span>"
            end
            if lasthtmlString ~= htmlString then
                SendNUIMessage({
                    toggle = true,
                    html = htmlString
                })
                lasthtmlString = htmlString
            end
        end
        if isDisplaying == false then
            SendNUIMessage({toggle = false})
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(Config.Duration)
        isDisplaying = false
        SendNUIMessage({toggle = false})
    end)
end)