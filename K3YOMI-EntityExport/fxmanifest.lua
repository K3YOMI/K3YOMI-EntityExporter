fx_version 'cerulean'
game 'gta5'

name "K3YOMI-EntityExport"
description "A simple framework based system to save temp maps"
author "K3YOMI@Github"
version "1.0.0"
client_scripts {'client/*.lua'}
server_scripts {'server/*.lua'}
export {'sendMapSaveRequest','deleteEntityMap','saveEntityMap','requestMap','importMap'}