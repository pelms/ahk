#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ****************************************************************
; ******** AHK Shortcuts for using the Tribal SITS Client ********

; ******** Useful shortcuts when using a laptop or keyboard without a NumPad

; Backtick key -> 'Gold' key
`::
    Send ·
return

; Alt Backtick -> Backtick
!`::
    Send {ASC 96}
return

; Numpad asterix from main keyboard (SITS 'Gold' wildcard ·*)
; N.B. This is effectively 'Ctrl + *' on UK keyboard
^+8::
    Send {NumpadMult}
return

; ******** Useful when copying between SITS client edit fields and Notepad++

; Copy contents of selected SITS Client edit field into Notepad++ and
; optionally switch to SRL Text language.
#IfWinActive ahk_class UniApplication
	^+=::	
		MyClip2 := ClipboardAll
		MouseMove, % A_CaretX, % A_CaretY+3
		MouseClick, right
		Sleep, 100
		Send, a^c
		ClipWait
		Send ^{Home}
		Sleep, 100
		IfWinExist ahk_class Notepad++ 	
		{
			WinActivate
			WinWaitActive
			Sleep, 100
			Send ^n
		} 
		Else 
		{
			Run "C:\Program Files (x86)\Notepad++\notepad++.exe" 
			WinActivate ahk_class Notepad++
			WinWaitActive ahk_class Notepad++
		}
		Sleep, 100
		Send ^v
		Sleep, 100
		Send ^{Home}
; Optionally select language (SRL Text language saved as 'zSRL'):
;		Send !lz
		Sleep, 100
		Clipboard := MyClip2
		MyClip2 = 		
	return	  
#IfWinActive

; Right-click > Select All > Copy
#IfWinActive ahk_class UniApplication
	^!c::
	  MouseMove, % A_CaretX, % A_CaretY+3
      MouseClick, right
      Sleep, 100
      Send, a^c
      ClipWait
  	  Send ^{Home}
	  ToolTip, Copied all
	  SetTimer, RemoveToolTip, 600	
   return	  
#IfWinActive
#IfWinActive ahk_class Notepad++
	^!c::	
	  caret_x := A_CaretX
	  caret_y := A_CaretY
      Send, ^a^c
      ClipWait
	  MouseMove, %caret_x%, %caret_y%
	  MouseClick, left
	  ToolTip, Copied all
	  SetTimer, RemoveToolTip, 600	
   return	  
#IfWinActive

; Right-click > Select All > Paste
#IfWinActive ahk_class UniApplication
	^!v::	
      MouseMove, % A_CaretX, % A_CaretY+3
	  MouseClick, right
      Sleep, 100
      Send, a^v
      ClipWait
	  Send ^{Home}
	  ToolTip, Pasted all
	  SetTimer, RemoveToolTip, 600	
   return	  
#IfWinActive

; Make 'Ctrl c' work in help window e.g. to copy names of fields
;  N.B. Need to keep mouse over highlighted text as couldn't get 
;       MouseMove command to work in the Help window.
#IfWinActive ahk_class UniApplication
	^c::
		Clipboard :=
		Clip0 := Clipboard
		Sleep, 100
		Send ^c
		sleep, 100
		if (Clipboard = Clip0) {
			; 'Ctrl+c' failed so use right mouse click instead
			;	MouseMove, % A_CaretX, % A_CaretY
			Sleep, 100
			MouseClick, right
			Sleep, 100
			;Send c
			Send, {Down 2}{Enter}
		}		
		ToolTip, Copied %Clipboard%
		SetTimer, RemoveToolTip, 600		
	return	  
#IfWinActive

