--- BACK END BY RTDTONINO#2060 ---

RegisterNetEvent('rtjv_itemcreator:crearitem',function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playername = GetPlayerName(source)

    if xPlayer.getGroup() == 'admin' then
        MySQL.Async.execute('INSERT INTO items (name, label, weight, rare, can_remove, status, quantity) VALUES (@name, @label, @weight, @rare, @can_remove, @status, @quantity)', {
            ['@name'] = data.name,
            ['@label'] = data.label,
            ['@weight'] = data.weight,
            ['@rare'] = 0,
            ['@can_remove'] = 1,
            ['@status'] = data.status,
            ['@quantity'] = data.quantity,
        })
        xPlayer.showNotification('RTJV ITEMS] [INFO] Item Agregado | ' .. data.name .. ' | ' .. data.label .. ' | ' .. data.weight .. ' | ')
        sendDiscord('RTJV ITEM CREATOR', 'El administrador ['.. playername ..'] creo el item ' .. data.label .. '  con el codigo de spawn de ' .. data.name .. ' y un peso de ' .. data.weight .. '')
    else
        xPlayer.showNotification("Permisos insuficientes")
    end
end)

RegisterNetEvent('rtjv_itemcreator:eliminar',function(data)
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
        xPlayer.triggerEvent('rtjv_itemcreator:abrir')
    else
        xPlayer.showNotification("Permisos insuficientes")
    end
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM items ', {
    }, function(result)
        for k = 1, #result, 1 do
            local name = result[k]['name']
            local label = result[k]['label']
            local status = result[k]['status']
            local quantity = result[k]['quantity']
            local Notify = RTD.CustomNotify
            
            if status == 'none' then
            elseif status == 'hunger' then
        
                ESX.RegisterUsableItem(name, function(source)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local qhunger = quantity * 10000
                    xPlayer.removeInventoryItem(name, 1)
            
                     xPlayer.triggerEvent('esx_status:add', 'hunger', qhunger)
                     xPlayer.triggerEvent('esx_basicneeds:onEat', source)
                    xPlayer.showNotification(Notify .. label .. ' x1')
                end)
        
            elseif status == 'thirst' then
        
                ESX.RegisterUsableItem(name, function(source)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local qthirst = quantity * 10000
                    xPlayer.removeInventoryItem(name, 1)
            
                     xPlayer.triggerEvent('esx_status:add', 'thirst', qthirst)
                     xPlayer.triggerEvent('esx_basicneeds:onDrink', source)
                    xPlayer.showNotification(Notify .. label .. '  x1')
                end)
        
            elseif status == 'health' then

                ESX.RegisterUsableItem(name, function(source)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local qhealth = quantity
                    xPlayer.removeInventoryItem(name, 1)

                    xPlayer.triggerEvent('rtjv_itemcreator:health', qhealth)
                    xPlayer.showNotification(Notify .. label .. '  x1')
                end)

            elseif status == 'armour' then

                ESX.RegisterUsableItem(name, function(source)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    local qarmour = quantity
                    xPlayer.removeInventoryItem(name, 1)

                    xPlayer.triggerEvent('rtjv_itemcreator:armour', qarmour)
                    xPlayer.showNotification(Notify .. label .. '  x1')
                end)
            end
        end
    end)
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
