local PlayerData = {}
ESX = exports["es_extended"]:getSharedObject()
dogbodycam = false

RegisterNetEvent("dog-bodycam:show")
AddEventHandler("dog-bodycam:show", function(daner, job)
    local year , month, day , hour , minute , second  = GetLocalTime()

    if dogbodycam == true then
        if string.len(tostring(minute)) < 2 then
            minute = '0' .. minute
        end
        if string.len(tostring(second)) < 2 then
            second = '0' .. second
        end
        SendNUIMessage({
            date = day .. '/'.. month .. '/' .. year .. ' ' .. hour .. ':' .. minute .. ':' .. second,
            daneosoby = daner,
            ranga = job,
            open = true,
        })
    end
end)
--else 
--    exports['mythic_notify']:SendAlert('inform', 'You are not police officer', 2500)
--end

RegisterCommand("bodycam", function()
    
    ESX.TriggerServerCallback('sove:item', function(qtty)
        if qtty > 0 then
            if not dogbodycam then
                dogbodycam = true
                TriggerEvent('dog-bodycam:show')
                if Config.Notify1 then
                    exports['mythic_notify']:SendAlert('success', 'Your body cam is ON!')
                end
                Citizen.Wait(1000)
                Citizen.Wait(3000)
            else
                dogbodycam = false
                Citizen.Wait(1000)
                Citizen.Wait(1000)
                TriggerEvent('dog-bodycam:close')
                if Config.Notify2 then
                    exports['mythic_notify']:SendAlert('success', 'Your body cam is OFF!')
                end
                Citizen.Wait(1000)
            end
        else
            if Config.Notify3 then
            exports['mythic_notify']:SendAlert('inform', 'You dont have a bodycam', 2500)
            end
        end
    end, 'bodycam')
end, false)

RegisterNetEvent("dog-bodycam:close")
AddEventHandler("dog-bodycam:close", function()
    SendNUIMessage({
        open = false
    })
    --SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)
end)

RegisterNetEvent('dog-bodycam:bodycam')
AddEventHandler('dog-bodycam:bodycam', function()
    ExecuteCommand('bodycam')
end)
