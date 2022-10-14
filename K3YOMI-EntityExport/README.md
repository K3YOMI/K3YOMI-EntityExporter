# Entity Exporter and Importer | FiveM
[![Typing SVG](https://readme-typing-svg.herokuapp.com?font=Inconsolata&duration=3000&color=D404F7&vCenter=true&height=25&lines=Have+questions%3F;Feel+free+to+DM+me+on+Discord!)](https://git.io/typing-svg)

## Contact Information 
<a href="mailto:chevybot123@gmail.com"><img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"></a>
<a href="https://discordapp.com/users/359794704847601674"><img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white" alt="Kiyomi#9081" ></a>

## Description
A live map importer and exporter framework


# Documentation
| **Exports** | **Description** |
| ------ | ------ |
| **requestMap(mapName)** | *Sends a NetEvent to the server to get a certain maps data* |
| **sendMapSaveRequest(mapName, mapData)** | *Sends a NetEvent to the server to save the exported map data* |
| **deleteEntityMap(entity)** | *Deleted the imported entity in the temp data* |
| **saveEntityMap(entity,model,x1,x2,x3,r1,r2,r3)** | *Imports the entity in the temp map data so we can export this later to a full map* |
| **importMap(mapName, properPlacement)** | *Imports the map name we selected and creates the objects* |

## Example (Internal)
```lua
Citizen.CreateThread(function()
    local Cloned = CreatePed(28, 587703123, 12.0,12.0,70.0,0.0,true,true)
    local entityCoords = GetEntityCoords(Cloned)
    local entityRot = GetEntityRotation(Cloned)
    saveEntityMap(Cloned, GetEntityModel(Cloned), entityCoords.x, entityCoords.y, entityCoords.z, entityRot.x, entityRot.y, entityRot.z)
    Wait(100)
    sendMapSaveRequest("mapTest1", tempDataSaving)
    Wait(100)
    requestMap('mapTest1')
    Wait(1000)
    importMap('mapTest1', false)
end)
```

## Example (External)
```lua
Citizen.CreateThread(function()
    local Cloned = CreatePed(28, 951767867, 12.0,12.0,70.0,0.0,true,true) -- Entity we spawned
    entityCoords = GetEntityCoords(Cloned) -- Get the entity Coords
    entityRot = GetEntityRotation(Cloned) -- Get the entity Rotation
    exports["K3YOMI-EntityExport"]:saveEntityMap(Cloned, GetEntityModel(Cloned), entityCoords.x, entityCoords.y, entityCoords.z, entityRot.x, entityRot.y, entityRot.z)
    Wait(100)
    exports["K3YOMI-EntityExport"]:sendMapSaveRequest("mapTest1", tempDataSaving) -- Save the map and export it to the server
    Wait(100)
    exports["K3YOMI-EntityExport"]:requestMap("mapTest1") -- Request server found maps
    Wait(1000)
    exports["K3YOMI-EntityExport"]:importMap('mapTest1', false) -- Import the selected map (Spawns the objects/entities)
end)
```
