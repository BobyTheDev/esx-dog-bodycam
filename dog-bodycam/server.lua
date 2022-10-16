ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('sove:item', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)
function getIdentity(source)

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = source})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 255 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
         if xPlayer.getInventoryItem('bodycam').count >= 1 then 
            local name = getIdentity(xPlayer.identifier)
			if xPlayer.get('sex') == 'm' then
				TriggerClientEvent('dog-bodycam:show', xPlayers[i],'Mr. ' .. name.lastname, '' .. ' '.. xPlayer.job.grade_label)
			elseif
			TriggerClientEvent('dog-bodycam:show', xPlayers[i],'Mrs. ' .. name.lastname, '' .. ' '.. xPlayer.job.grade_label) then
		else
			TriggerClientEvent('dog-bodycam:close', xPlayers[i])
		end
	end
	end
end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if item.name == 'bodycam' and item.count <= 0 then
	   TriggerClientEvent('dog-bodycam:close', source)
	end
end)

ESX.RegisterUsableItem('bodycam', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('dog-bodycam:bodycam', source)
end)