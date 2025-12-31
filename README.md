# bvmba_notify

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Un sistema di notifiche standalone, moderno e completamente personalizzabile per FiveM. Progettato per essere facile da integrare in qualsiasi script con un semplice export.

## 📋 Caratteristiche

- ✅ **Facile da usare** - Integrazione con una sola riga di codice
- 🎨 **Completamente personalizzabile** - Colori, posizioni, durate e molto altro
- 🔊 **Effetti sonori** - Suoni personalizzati per ogni tipo di notifica (opzionale)
- 📱 **Design moderno** - UI pulita e animazioni fluide
- 🎯 **8 posizioni** - Top, middle, bottom combinati con left, right, middle
- 🎨 **Codici colore** - Supporto per codici colore FiveM (~r~, ~g~, ~b~, etc.)
- ⚡ **Performance ottimizzate** - Sistema leggero e veloce

## 🚀 Installazione

1. Scarica l'ultima versione dalla sezione [Releases](https://github.com/bvmba/bvmba_notify/releases)
2. Estrai la cartella nella directory `resources` del tuo server
3. Aggiungi la risorsa al tuo `server.cfg`:
   ```cfg
   ensure bvmba_notify
   ```
4. Riavvia il server o avvia la risorsa manualmente

## 📖 Utilizzo

### Esempio base

```lua
-- Notifica semplice
exports['bvmba_notify']:Notify("Titolo", "Messaggio", "info")

-- Con tutti i parametri
exports['bvmba_notify']:Notify("Successo!", "Operazione completata", "success", 5000, "top-right")
```

### Tipi di notifica

- `success` - Notifica di successo (verde)
- `error` - Notifica di errore (rosso)
- `info` - Notifica informativa (blu)
- `warning` - Notifica di avviso (arancione)

### Posizioni disponibili

- `top-right` (default)
- `top-left`
- `top-middle`
- `middle-right`
- `middle-left`
- `bottom-right`
- `bottom-left`
- `bottom-middle`

### Esempi avanzati

```lua
-- Notifica con durata personalizzata
exports['bvmba_notify']:Notify("Attenzione", "Questo messaggio dura 10 secondi", "warning", 10000)

-- Notifica in posizione personalizzata
exports['bvmba_notify']:Notify("Info", "Notifica in basso a sinistra", "info", 5000, "bottom-left")

-- Notifica con codici colore FiveM
exports['bvmba_notify']:Notify("~g~Successo", "~r~Errore ~w~nel testo", "success")

-- Esempio in uno script
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 38) then -- E
            exports['bvmba_notify']:Notify("Azione", "Hai premuto E!", "success", 3000)
        end
    end
end)
```

## ⚙️ Configurazione

Tutte le impostazioni sono configurabili nel file `config.lua`:

```lua
Config = {}

-- Posizione di default
Config.Position = "top-right"

-- Durata di default in millisecondi
Config.DefaultDuration = 5000

-- Abilita/disabilita suoni
Config.NotificationSound = true

-- Numero massimo di notifiche simultanee
Config.MaxNotifications = 4

-- Personalizza colori e icone per ogni tipo
Config.Types = {
    success = { 
        color = "#2ecc71", 
        borderColor = "#1f9c4d",
        icon = "check_circle" 
    },
    error = { 
        color = "#e74c3c", 
        borderColor = "#c0392b",
        icon = "error" 
    },
    -- ... altri tipi
}
```

### Personalizzazione colori CSS

Puoi anche personalizzare i colori modificando le variabili CSS in `html/style.css`:

```css
:root {
    --background: rgba(20, 20, 20, 0.9);
    --text-color: #ffffff;
    --success-color: #2ecc71;
    --error-color: #e74c3c;
    /* ... altri colori */
}
```

## 🎨 Codici Colore Supportati

Il sistema supporta i codici colore standard di FiveM:

- `~r~` - Rosso
- `~g~` - Verde
- `~b~` - Blu
- `~y~` - Giallo
- `~p~` - Viola
- `~c~` - Grigio
- `~m~` - Marrone
- `~u~` - Nero
- `~o~` - Arancione
- `~s~` - Reset colore
- `~w~` - Bianco (implicito)

Esempio:
```lua
exports['bvmba_notify']:Notify("~g~Titolo ~w~Normale", "~r~Rosso ~b~Blu ~g~Verde", "info")
```

## 📝 API Reference

### Export: Notify

```lua
exports['bvmba_notify']:Notify(title, message, type, duration, position)
```

**Parametri:**
- `title` (string, richiesto) - Titolo della notifica
- `message` (string, richiesto) - Messaggio della notifica
- `type` (string, opzionale) - Tipo: "success", "error", "info", "warning" (default: "info")
- `duration` (number, opzionale) - Durata in millisecondi (default: Config.DefaultDuration)
- `position` (string, opzionale) - Posizione sullo schermo (default: Config.Position)

## 📄 Licenza

Questo progetto è rilasciato sotto licenza MIT. Vedi il file `LICENSE` per maggiori dettagli.

## 👤 Autore

**bvmba**

- GitHub: [@bvmba](https://github.com/bvmba)

---

⭐ Se ti piace questo script, considera di lasciare una stella su GitHub!

