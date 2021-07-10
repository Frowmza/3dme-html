RegisterNetEvent("me:image")
AddEventHandler("me:image", function(Text, Source)
    local PlayerId = GetPlayerFromServerId(Source)
    local IsDisplaying = true
    Citizen.CreateThread(function()
        while IsDisplaying do
            Citizen.Wait(0)
            local htmlString = ""
            local SourceCoords = GetEntityCoords(GetPlayerPed(PlayerId))
            local NearCoords = GetEntityCoords(PlayerPedId())
            local Distance = Vdist2(SourceCoords, NearCoords)
            if Distance < 25.0 then
                local onScreen, xxx, yyy =
                    GetHudScreenPositionFromWorldPosition(
                        SourceCoords.x + Config.CoordsX,
                        SourceCoords.y + Config.CoordsY,
                        SourceCoords.z + Config.CoordsZ)
                htmlString =
                    htmlString ..
                    '<span style="position: absolute; left: ' ..
                    xxx * 100 ..
                    "%;top: " .. yyy * 100 .. '%;"><p class="box sb3">' .. Text .. "</p></span>"
            end
            if lasthtmlString ~= htmlString then
                SendNUIMessage({
                    toggle = true,
                    html = htmlString
                })
                lasthtmlString = htmlString
            end
        end
        if IsDisplaying == false then
            SendNUIMessage({toggle = false})
        end
    end)
    Citizen.CreateThread(function()
        Citizen.Wait(Config.Duration)
        IsDisplaying = false
        SendNUIMessage({toggle = false})
    end)
end)