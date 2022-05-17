--- BACK END BY RTDTONINO#2060 ---

local display = false

RegisterNetEvent('rtjv_itemcreator:abrir')
AddEventHandler('rtjv_itemcreator:abrir', function(bool)
    SetDisplay(true)
    ExecuteCommand('e tablet2')
end)

RegisterNUICallback("salir", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("crearitem1", function(data)
    TriggerServerEvent('rtjv_itemcreator:crearitem', data)
    SetDisplay(false)
end)

RegisterNUICallback("eliminaritem", function(data)
    TriggerServerEvent('rtjv_itemcreator:eliminar', data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end


RegisterNetEvent('rtjv_itemcreator:health', function(qhealth)
    local ped = PlayerPedId()
    local currenthealth = GetEntityHealth(ped)
    local newhealth = currenthealth + qhealth



    if ped then
        SetEntityHealth(ped, newhealth)
    end
end)

RegisterNetEvent('rtjv_itemcreator:armour', function(qarmour)
    local ped = PlayerPedId()
    
    if ped then
        AddArmourToPed(ped, qarmour)
    end
end)
