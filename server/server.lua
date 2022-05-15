--- BACK END BY RTDTONINO#2060 ---

RegisterNetEvent('crearitem',function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playername = GetPlayerName(source)

    if xPlayer.getGroup() == 'admin' then
        MySQL.Async.execute('INSERT INTO items (name, label, weight, rare, can_remove) VALUES (@name, @label, @weight, @rare, @can_remove)', {
            ['@name'] = data.name,
            ['@label'] = data.label,
            ['@weight'] = data.weight,
            ['@rare'] = 0,
            ['@can_remove'] = 1,
        })
        xPlayer.showNotification('RTJV ITEMS] [INFO] Item Agregado | ' .. data.name .. ' | ' .. data.label .. ' | ' .. data.weight .. ' | ')
        sendDiscord('RTJV ITEM CREATOR', 'El administrador ['.. playername ..'] creo el item ' .. data.label .. '  con el codigo de spawn de ' .. data.name .. ' y un peso de ' .. data.weight .. '')
    else
        xPlayer.showNotification("Permisos insuficientes")
    end
end)

RegisterNetEvent('eliminar',function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playername = GetPlayerName(source)

    if xPlayer.getGroup() == 'admin' then
        MySQL.Async.execute('DELETE FROM items WHERE name = @name', {
            ['@name'] = data.name,
        })
        xPlayer.showNotification('[RTJV ITEMS] [INFO] Item Eliminado | ' .. data.name .. ' | ')
        sendDiscord('RTJV ITEM CREATOR', 'El administrador ['.. playername ..'] elimino el item ' .. data.name .. '')
    else
        xPlayer.showNotification("Permisos insuficientes")
    end
end)

RegisterCommand('crearitem', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == 'admin' then
        xPlayer.triggerEvent('abrir')
    else
        xPlayer.showNotification("Permisos insuficientes")
    end
end)

--- DISCORD WEBHOOK 

local webhookurl = RTD.WebhookURL

function sendDiscord(name, message)
	local content = {
        {
        	["color"] = '5015295',
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "[RTJV ITEMS]",
            },
        }
    }
  	PerformHttpRequest(webhookurl, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end
