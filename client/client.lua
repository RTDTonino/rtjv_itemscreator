--- BACK END BY RTDTONINO#2060 ---

local display = false

RegisterNetEvent('abrir')
AddEventHandler('abrir', function(bool)
    SetDisplay(true)
    ExecuteCommand('e tablet2')
end)

RegisterNUICallback("salir", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("crearitem1", function(data)
    TriggerServerEvent('crearitem', data)
    SetDisplay(false)
end)

RegisterNUICallback("eliminaritem", function(data)
    TriggerServerEvent('eliminar', data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end
