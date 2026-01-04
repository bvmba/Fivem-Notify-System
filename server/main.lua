if not Config then
    print("^1[bvmba_notify] ERRORE: Config non trovato! Assicurati che config.lua sia caricato.^7")
    Config = {
        DefaultDuration = 5000,
        Position = "top-right"
    }
end

-- Uso (server-side): exports['bvmba_notify']:Notify(playerId, title, message, type, duration, position)
-- playerId: ID del giocatore a cui inviare la notifica
-- type: "success", "error", "info", "warning" (default: "info")
-- duration: durata della notifica in millisecondi (default: Config.DefaultDuration)
-- position: posizione della notifica (default: Config.Position)
exports('Notify', function(playerId, title, message, type, duration, position)
    if not playerId or not title or not message then
        print("^1[bvmba_notify] ERRORE: Parametri mancanti nell'export Notify!^7")
        return
    end

    TriggerClientEvent('bvmba_notify:show', playerId, {
        title = title,
        message = message,
        type = type or "info",
        duration = duration or Config.DefaultDuration,
        position = position or Config.Position
    })
end)

RegisterCommand('bvmbanotifytest', function(source)
    local playerId = source
    if playerId > 0 then
        exports['bvmba_notify']:Notify(playerId, "Test Notifica", "Sistema di notifiche funzionante!", "success", 5000, "middle-right")
        exports['bvmba_notify']:Notify(playerId, "Test Notifica", "Sistema di notifiche funzionante!", "error", 5000, "middle-right")
        exports['bvmba_notify']:Notify(playerId, "Test Notifica", "Sistema di notifiche funzionante!", "info", 5000, "middle-right")
        exports['bvmba_notify']:Notify(playerId, "Test Notifica", "Sistema di notifiche funzionante!", "warning", 5000, "middle-right")
    end
end, false)