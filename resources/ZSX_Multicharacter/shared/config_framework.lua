ESX = GetResourceState('es_extended') == 'started' and exports['es_extended']:getSharedObject() or false
QBCore = GetResourceState('qb-core') == 'started' and exports['qb-core']:GetCoreObject() or false
FrameworkSelected = GetResourceState('es_extended') == 'started' and 'ESX' or GetResourceState('qb-core') == 'started' and 'QBCore'
ZSX_UI = 'ZSX_UI'
UserInterfaceActive = GetResourceState(ZSX_UI) == 'started'