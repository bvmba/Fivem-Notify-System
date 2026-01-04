const w = window;

// Codici colore FiveM supportati: ~r~ ~g~ ~b~ ~y~ ~p~ ~c~ ~m~ ~u~ ~o~
const codes = {
    "~r~": "#c0392b", "~b~": "#378cbf", "~g~": "#2ecc71", "~y~": "yellow",
    "~p~": "purple", "~c~": "grey", "~m~": "#212121", "~u~": "black", "~o~": "#fb9b04"
};

let audioContext;
document.addEventListener("click", initAudioContext, { once: true });
document.addEventListener("keydown", initAudioContext, { once: true });

function initAudioContext() {
    if (!audioContext) audioContext = new (window.AudioContext || window.webkitAudioContext)();
}

function playNotificationSound(soundConfig) {
    if (!audioContext) initAudioContext();
    if (!soundConfig) return;
    
    const oscillator = audioContext.createOscillator();
    const gainNode = audioContext.createGain();

    oscillator.type = soundConfig.type || "sine";
    oscillator.frequency.setValueAtTime(soundConfig.frequency || 600, audioContext.currentTime);

    const volume = soundConfig.volume || 0.3;
    gainNode.gain.setValueAtTime(volume, audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + (soundConfig.duration || 100) / 1000);

    oscillator.connect(gainNode);
    gainNode.connect(audioContext.destination);

    oscillator.start();
    oscillator.stop(audioContext.currentTime + (soundConfig.duration || 100) / 1000);
}

const replaceColors = (str, obj) => {
    let strToReplace = str;
    for (const id in obj) strToReplace = strToReplace.replace(new RegExp(id, "g"), obj[id]);
    return strToReplace;
};

const sanitizeHTML = str => {
    const temp = document.createElement("div");
    temp.textContent = str;
    return temp.innerHTML;
};

const processLineBreaks = str => str.replace(/&lt;br&gt;/g, "<br>");

const notification = (data) => {
    if (typeof $ === "undefined") return console.error("jQuery è richiesto.");

    let title = data.title ? sanitizeHTML(data.title).replace(/~s~/g, "") : "";
    let message = data.message ? sanitizeHTML(data.message).replace(/~s~/g, "") : "";

    for (const color in codes) {
        const obj = { [color]: `<span style="color: ${codes[color]}">`, "~s~": "</span>" };
        if (title.includes(color)) title = replaceColors(title, obj);
        if (message.includes(color)) message = replaceColors(message, obj);
    }

    title = processLineBreaks(title);
    message = processLineBreaks(message);
    const id = `notify-${Math.floor(Math.random() * 100000)}`;
    const duration = data.duration || 3000;
    const position = data.position || "top-right";
    const container = $(`#${position}`);
    const colorConfig = data.colorConfig || { color: "#3498db", borderColor: "#2980b9" };

    if (!container.length) return console.error(`Container #${position} non trovato.`);

    const radius = 16;
    const circumference = 2 * Math.PI * radius;

    const notif = $(`
        <div id="${id}" class="notify notify-${data.type} fadeIn" style="border-left-color: ${colorConfig.borderColor}">
            <div class="notify-content">
                <h3 class="notify-title">${title}</h3>
                <p class="notify-text">${message}</p>
            </div>
            <div class="notify-progress-circular">
                <svg viewBox="0 0 36 36">
                    <circle class="circle-bg" cx="18" cy="18" r="${radius}"/>
                    <circle class="circle-progress" cx="18" cy="18" r="${radius}" 
                            stroke-dasharray="${circumference}" 
                            stroke-dashoffset="0"
                            style="stroke: ${colorConfig.color}"/>
                </svg>
            </div>
        </div>
    `).appendTo(container);

    const progressCircle = $(`#${id} .circle-progress`);
    progressCircle.css({ transition: `stroke-dashoffset ${duration}ms linear` });
    
    requestAnimationFrame(() => {
        requestAnimationFrame(() => {
            progressCircle.css("stroke-dashoffset", circumference);
        });
    });

    if (data.notificationSoundEnabled && data.soundConfig) {
        playNotificationSound(data.soundConfig);
    }

    setTimeout(() => {
        $(`#${id}`).removeClass("fadeIn").addClass("fadeOut");
        setTimeout(() => $(`#${id}`).remove(), 500);
    }, duration);

    return notif;
};

w.addEventListener("message", (event) => {
    notification({
        type: event.data.type,
        title: event.data.title || "Nuova Notifica",
        message: event.data.message || "",
        duration: event.data.duration,
        position: event.data.position,
        notificationSoundEnabled: event.data.notificationSoundEnabled,
        soundConfig: event.data.soundConfig,
        colorConfig: event.data.colorConfig
    });
});