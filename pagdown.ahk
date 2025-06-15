; keep this groupadd on top
;;;;;;;;;;;;;;;;;;;;;;;;
;;; SpecificStuff ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;

;GroupAdd, altf4 , ahk_class ApplicationFrameWindow
;GroupAdd, altf4 , ahk_class GraphApp
;GroupAdd, altf4 , ahk_class RGLDevice

GroupAdd, 0ctrlw_insteadof_altf4 , ahk_exe code.exe
GroupAdd, 0ctrlw_insteadof_altf4 , ahk_exe chrome.exe
GroupAdd, 0ctrlw_insteadof_altf4 , ahk_exe gvim.exe
GroupAdd, 0ctrlw_insteadof_altf4, ahk_exe SumatraPDF.exe

GroupAdd, 78toswitchtab, ahk_exe ApplicationFrameHost.exe
GroupAdd, 78toswitchtab, ahk_exe SumatraPDF.exe
GroupAdd, 78toswitchtab, ahk_exe chrome.exe
GroupAdd, 78toswitchtab, ahk_exe AcrobatSDIWindow
GroupAdd, 78toswitchtab, ahk_exe gvim.exe
GroupAdd, 78toswitchtab, ahk_exe code.exe
return



#IfWinActive ahk_group 0ctrlw_insteadof_altf4
$0::
Send, ^w
return

#IfWinActive ahk_group 78toswitchtab
$5::
Send, ^+{Tab}}
return
	
$6::
Send, ^{Tab}}
return

#IfWinActive

;;;;;;;keeps num pad off permanently
SetNumlockState, AlwaysOff

;;;;;;;set num pad with num off
$SC04F::1
$SC050::2
$SC051::3
$SC04B::4
$SC04C::5
$SC04D::6
$SC047::7
$SC048::8
$SC049::9
$SC052::0
$SC053::.


;;;;;;;; other ;;;;;;;;;;;;;

^7::suspend
return

CapsLock::Send, {Esc}

SC056::Send, ^r ;;; stupid english layout key on the left of Z

!`::Send,{ASC 0180} ;; broken in npp it seems

$Home::Send, ^f
$End::Send, ^r


^+SPACE::  Winset, Alwaysontop, , A

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; number  row ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

$1::Send, ^``

$2::
Send,!{Tab}
return

$3::
Send, {PgUp}
return


$4::
Send, {PgDn}
return

$7::Send,{Home}

$8::Send,{End}

$9::
Send, ^t
return

$0::
Send,!{F4}
return


;;;; FunctionRow ;;;

$Esc::Send, {Enter}
^Esc::Send, ^+``

F1::
Send, 1
return

F2::
Send, 2
return

F3::
Send, 3
return

F4::
Send, 4
return

F5::
Send, 5
return

F6::
Send, 6
return

$F7::
Send, 7
return

F8::
Send, 8
return

F9::
Send, 9
return

F10:: Send, 0

F11::
Send, {F7}
return

F12::Send,^u

Ins::
Send, ^d
return

^F5::
if !WinExist("ahk_exe chrome.exe")
{
Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
}
else
{	
	WinGet, WinListVariable, List, ahk_exe chrome.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="chrome.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe chrome.exe
}
return


^F6::
if !WinExist("ahk_exe code.exe")
{
Run "C:\Users\ischi\AppData\Local\Programs\Microsoft VS Code\Code.exe"
}
else
{
	WinGet, WinListVariable, List, ahk_exe code.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="Code.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe Code.exe
}
return

^F7::
if !WinExist("ahk_exe gvim.exe")
{
Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Vim 9.0\gVim"
}
else
{
	WinGet, WinListVariable, List, ahk_exe gvim.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="gvim.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe gvim.exe
}
return

^F8::
if !WinExist("ahk_exe ApplicationFrameHost.exe")
{
Run "C:\Users\ischi\OneDrive\Desktop\Whatsapp - Shortcut.lnk"
}
else
{
	WinGet, WinListVariable, List, ahk_exe ApplicationFrameHost.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="ApplicationFrameHost.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe ApplicationFrameHost.exe
}
return

^F9::
if !WinExist("ahk_exe SumatraPDF.exe")
{
Run "C:\Users\ischi\AppData\Local\SumatraPDF\SumatraPDF.exe"
}
else
{
	WinGet, WinListVariable, List, ahk_exe SumatraPDF.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="SumatraPDF.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe SumatraPDF.exe
}
return

^F10::
if !WinExist("ahk_class CabinetWClass ahk_exe explorer.exe")
{
Run "C:\WINDOWS\explorer"
}
else
{
	WinGet, WinListVariable, List, ahk_class CabinetWClass ahk_exe explorer.exe
	if (WinListVariable>1)
	{
		;MsgBox, You typed btw.
		WinGet, ActiveExe, ProcessName, A
		;MsgBox % "You typed twice " . ActiveExe
		if (ActiveExe=="explorer.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_class CabinetWClass ahk_exe explorer.exe
}
return

^F11::
if !WinExist("ahk_exe OUTLOOK.exe")
{
Run "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"
}
else
{
	WinGet, WinListVariable, List, ahk_exe OUTLOOK.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="OUTLOOK.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe OUTLOOK.exe
}
return

^F12::
if !WinExist("ahk_exe Teams.exe")
{
Run "C:\Program Files (x86)\Microsoft Office\root\Office16\Teams.EXE"
}
else
{
	WinGet, WinListVariable, List, ahk_exe Teams.exe
	if (WinListVariable>1)
	{
		WinGet, ActiveExe, ProcessName, A
		if (ActiveExe=="Teams.exe")
		{
		WinSet, Bottom,, A
		}
	}
	WinActivate, ahk_exe Teams.exe
}
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;  MOUSE  ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


$RButton::MButton
$MButton::RButton


+WheelDown::
Send, {PgDn}
return

+WheelUp::
Send, {PgUp}
return

;!WheelDown::
;Send, {Volume_Down}
;return
;
;!WheelUp::
;Send, {Volume_Up}
;return
;
;!LButton::
;Send, {Volume_Mute}



;___________________________________

; !q::
;  CoordMode, Mouse, Screen ;
;  MouseGetPos, MouseX
;  if (MouseX > A_ScreenWidth) {
;    MouseMove, A_ScreenWidth/2, A_ScreenHeight/2, 0
;  } else {
;    MouseMove, 3*A_ScreenWidth/2, A_ScreenHeight/2, 0
;  }
; return


;Pause::
;Send, ^w
;return


;3::
;Send, {{}
;return

;4::
;Send, {}}
;return

;$+5::
;Send, {Text}#include
;return

;5::
;Send, {^}
;return

;6::
;Send, {`$}
;return

;7::
;Send, {&}
;return

;8::
;Send, {*}
;return

;9::
;Send, {text}(
;return

;0::
;Send, {text})
;return

;^Up::
;SendInput, {Up}{Up}{Up}{Up}
;return

;^Down::
;SendInput, {Down}{Down}{Down}{Down}
;return
