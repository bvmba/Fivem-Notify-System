RegisterNetEvent('bvmba_notify:show', function(data)
    if not Config or not Config.Types then
        print("^1[bvmba_notify] ERRORE: Config non inizializzato correttamente!^7")
        return
    end
    
    local notifyType = data.type or "info"
    local typeConfig = Config.Types[notifyType] or Config.Types["info"]
    
    SendNUIMessage({
        action = "notify",
        title = data.title or "",
        message = data.message or "",
        type = notifyType,
        duration = data.duration or Config.DefaultDuration,
        position = data.position or Config.Position,
        notificationSoundEnabled = Config.NotificationSound,
        soundConfig = {
            frequency = typeConfig.soundFrequency,
            duration = typeConfig.soundDuration,
            volume = typeConfig.soundVolume,
            type = typeConfig.soundType
        },
        colorConfig = {
            color = typeConfig.color,
            borderColor = typeConfig.borderColor
        }
    })
end)

-- Uso: exports['bvmba_notify']:Notify(title, message, type, duration, position)
-- type: "success", "error", "info", "warning" (default: "info")
exports('Notify', function(title, message, type, duration, position)
    if not Config then
        print("^1[bvmba_notify] ERRORE: Config non trovato! Assicurati che config.lua sia caricato.^7")
        return
    end
    
    TriggerEvent('bvmba_notify:show', {
        title = title,
        message = message,
        type = type or "info",
        duration = duration or Config.DefaultDuration,
        position = position or Config.Position
    })
end)

RegisterCommand('bvmbanotifytest', function()
    exports[GetCurrentResourceName()]:Notify("Test Notifica", "Sistema di notifiche funzionante!", "success", 5000)
end, false)

