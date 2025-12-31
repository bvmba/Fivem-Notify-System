fx_version 'cerulean'
game 'gta5'

author 'bvmba'
description 'Sistema di notifiche completamente custom - by bvmba'
version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/app.js'
}

exports {
    'Notify'
}
