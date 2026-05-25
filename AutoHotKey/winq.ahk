#Requires AutoHotkey v2.0
#UseHook

if !A_IsAdmin {
    Run '*RunAs "' A_ScriptFullPath '"'
    ExitApp
}

#q:: {
    Send("!{F4}")
}
