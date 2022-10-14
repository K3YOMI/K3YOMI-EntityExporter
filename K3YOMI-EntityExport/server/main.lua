--[[
Author : K3YOMI
Date : 2022-10-13
Description : FiveAC Entity Export Framework to save maps easily
]]--

RegisterNetEvent("K3YOMI:Client:ImportMapData")
RegisterNetEvent("K3YOMI:Client:RequestMaps")


AddEventHandler("K3YOMI:Client:ImportMapData", function(mapName, mapData)
    local tempPlayer = source 
    local readNode = LoadResourceFile(GetCurrentResourceName(), "maps.json")
    local recordAdd = json.decode(readNode)
    local newRecord = {}
    newRecord['Time Saved'] = os.date("%B %d, %Y | %I:%M %p");
    newRecord['Map Name'] = mapName
    newRecord['Entity Data'] = mapData
    newRecord['Created By'] = GetPlayerName(tempPlayer)
    recordAdd[mapName] = newRecord
    SaveResourceFile(GetCurrentResourceName(), "maps.json", json.encode(recordAdd, {indent = true}), -1)
end)

AddEventHandler("K3YOMI:Client:RequestMaps", function()
    local tempPlayer = source 
    local readNode = LoadResourceFile(GetCurrentResourceName(), "maps.json")
    local recordAdd = json.decode(readNode)
    TriggerClientEvent("K3YOMI:Server:RequestMapsRecieved", tempPlayer, recordAdd)
end)