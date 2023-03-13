ESX = nil

TriggerEvent(_bConfig.InitESX, function(obj) ESX = obj end)

desactivePauseMenu = function(bool)
    if bool then
        CreateThread(function()
            while bool do
                SetPauseMenuActive(false)
                Wait(3)
            end
        end)
        Wait(150)
        bool = false
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    DisableControlAction(2, 199, true) -- Disable pause screen
end)

local displayUI = false

RegisterKeyMapping("openpaused", "Affichage du Pause Menu", "keyboard", "ESCAPE")

RegisterCommand("openpaused", function()
    desactivePauseMenu(true)
    active = true
    if active then
        if not IsPauseMenuActive() and not IsNuiFocused() then
            ESX.TriggerServerCallback('bPauseMenu:getInfosPlayer', function(i_player)
                table.insert(i_player, {
                job_grade1 = ESX.PlayerData.job.grade_label,
                job_grade2 = ESX.PlayerData.job2.grade_label,
                })
                SetDisplay(true, "ui", i_player)
                TransitionToBlurred(1000)
            end)
            desactivePauseMenu(false)
        end
        active = false
    end
end)

function closePauseMenu()
    TransitionFromBlurred(1000)
    displayUI = false
    SetDisplay(displayUI, "ui")
end

RegisterNUICallback("disconnect", function(data)
	TriggerServerEvent('bPauseMenu:DropPlayer')
    closePauseMenu()
end)

RegisterNUICallback("map", function(data)
	ActivateFrontendMenu("FE_MENU_VERSION_MP_PAUSE", true, 0)
    Wait(100)
    PauseMenuceptionGoDeeper(-1) 
    PauseMenuceptionTheKick()
    closePauseMenu()
end)

RegisterNUICallback("settings", function(data)
	ActivateFrontendMenu('FE_MENU_VERSION_LANDING_MENU',0, 1)
    closePauseMenu()
end)

RegisterNUICallback("exit", function(data)
    closePauseMenu()
end)

RegisterNUICallback("main", function(data)
    closePauseMenu()
end)

function SetDisplay(bool, id, data)
    display = bool
    if id == "ui" then 
        SetNuiFocus(bool, bool)
        SetNuiFocusKeepInput(false)
        DisableIdleCamera(bool)
    end
    if data then
        SendNUIMessage({
            type = id,
            status = bool,
            data = data
        })
        return
    else
        SendNUIMessage({
            type = id,
            status = bool,
        })
    end
end

if _bConfig.ActivateCustomMenu then
    CreateThread(function()
        while true do
            Wait(0)
            DisableControlAction(2, 199, true) -- Disable pause screen
            AddTextEntry('PM_SCR_SET', _bConfig.SettingTextCategory)
            AddTextEntry('PM_PANE_CFX', _bConfig.SettingTextFiveM)
        end
    end)
end