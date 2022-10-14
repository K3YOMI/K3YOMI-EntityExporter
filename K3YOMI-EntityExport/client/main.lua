--[[
Author : K3YOMI
Date : 2022-10-13
Description : FiveAC Entity Export Framework to save maps easily
]]--

tempDataSaving = {} -- This is the table that will hold the data for the map being saved
currentlyLoadedMapObjects = {}
function sendMapSaveRequest(mapName, mapData) -- This function is called when the user registeres the export and sends the saved [tempDataSaving] table to the server
    TriggerServerEvent("K3YOMI:Client:ImportMapData", mapName, mapData)
    tempDataSaving = {}
end
function deleteEntityMap(entity) -- This function is called when the user registeres the export and deletes an entity from the [tempDataSaving] table
    tempDataSaving[entity] = nil
end
function saveEntityMap(entity, model,posX,posY,posZ,RotX,RotY,RotZ) -- This function is called when the user registeres the export and saves an entity to the [tempDataSaving] table
    local entityType = GetEntityType(entity)
    local data = {}
    data.EntityType = entityType 
    data.EntityModel = model 
    data.PosX = posX
    data.PosY = posY
    data.PosZ = posZ
    data.RotX = RotX
    data.RotY = RotY
    data.RotZ = RotZ
    tempDataSaving[entity] = data
end
function requestMap(mapName)
    TriggerServerEvent("K3YOMI:Client:RequestMap", mapName)
end
function importMap(mapName, properPlacement)
    for d,e in pairs(currentlyLoadedMapObjects['Entity Data']) do
        Wait(100)
        if e['EntityType'] == 1 then
            local Cloned = CreatePed(28, e['EntityModel'], e['PosX'],e['PosY'],e['PosZ'],0.0,true,true)
            SetEntityRotation(Cloned, e['RotX'],e['RotY'],e['RotZ'])
            SetEntityLodDist(Cloned, 5000)
        end
        if e['EntityType'] == 3 then
            local Cloned = CreateObject(e['EntityModel'], e['PosX'],e['PosY'],e['PosZ'],true,true,true)
            SetEntityRotation(Cloned, e['RotX'],e['RotY'],e['RotZ'])
            SetEntityLodDist(Cloned, 5000)
            if properPlacement == (true) then
                getEntityHeight = GetEntityHeightAboveGround(Cloned)
                getLastCoords = GetEntityCoords(Cloned)
                SetEntityCoords(Cloned, getLastCoords.x, getLastCoords.y, getLastCoords.z - getEntityHeight)
                getEntityHeight = GetEntityHeightAboveGround(Cloned)
            end
        end
        if e['EntityType'] == 2 then
            local Cloned = CreateVehicle(e['EntityModel'], e['PosX'],e['PosY'],e['PosZ'],0.0,true,true)
            SetEntityRotation(Cloned, e['RotX'],e['RotY'],e['RotZ'])
            SetEntityLodDist(Cloned, 5000)
        end
        print('[DEBUG] Imported Entity : '..e['EntityModel'])
    end
end
RegisterNetEvent("K3YOMI:Server:RequestMapRecieved") -- This is the event that will be called when the client requests the maps
AddEventHandler("K3YOMI:Server:RequestMapRecieved", function(_data)
    currentlyLoadedMapObjects = _data
end)

