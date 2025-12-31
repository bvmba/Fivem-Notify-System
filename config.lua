Config = {}

-- Posizione: "top-right", "top-left", "bottom-right", "bottom-left", "top-middle", "bottom-middle", "middle-left", "middle-right"
Config.Position = "middle-right"

-- Durata in millisecondi (5000 = 5 secondi)
Config.DefaultDuration = 5000

-- Suoni on/off
Config.NotificationSound = true

-- Limite notifiche simultanee
Config.MaxNotifications = 4

-- Personalizza colori e suoni per ogni tipo
Config.Types = {
    success = { 
        color = "#2ecc71", 
        borderColor = "#1f9c4d",
        soundFrequency = 800,
        soundDuration = 100,
        soundVolume = 0.3,
        soundType = "sine"
    },
    error = { 
        color = "#e74c3c", 
        borderColor = "#c0392b",
        soundFrequency = 300,
        soundDuration = 150,
        soundVolume = 0.3,
        soundType = "sine"
    },
    info = { 
        color = "#3498db", 
        borderColor = "#2980b9",
        soundFrequency = 600,
        soundDuration = 100,
        soundVolume = 0.3,
        soundType = "sine"
    },
    warning = { 
        color = "#f39c12", 
        borderColor = "#d35400",
        soundFrequency = 450,
        soundDuration = 125,
        soundVolume = 0.3,
        soundType = "sine"
    }
}
