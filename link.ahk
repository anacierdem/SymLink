#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
 ;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

var=%1%

FileSelectFolder, OutputVar, , 3
if OutputVar !=
{
	Progress, 25

	StringGetPos, pos, var, \, R
	StringTrimLeft, lastItem, var, pos

	IfExist, %OutputVar%%lastItem%
	{
		MsgBox Error, target exists!
		exit
	}
	
	FileMoveDir, %var%\, %OutputVar%%lastItem%

	Progress, 50
	
	if ErrorLevel
	{
		
		Progress, Off
		
		MsgBox Error, cannot move files, %var% -> %OutputVar%%lastItem%
		
		Progress, 65
		
		FileMoveDir, %OutputVar%%lastItem%, %var%\, 2
		
		Progress, 75
		
		FileRemoveDir, %OutputVar%%lastItem%, 1
	}
	else 
	{
		Progress, 65
	
		FileRemoveDir, %var%\, 1
		
		Progress, 75
		
		Run, cmd.exe 
		WinWait, Administrator: C:\Windows\system32\cmd.exe
		IfWinNotActive, Administrator: C:\Windows\system32\cmd.exe, , WinActivate, Administrator: C:\Windows\system32\cmd.exe
		WinWaitActive, Administrator: C:\Windows\system32\cmd.exe
		SendInput mklink /D "%var%" "%OutputVar%%lastItem%"{Enter}exit{Enter}
	}
	
	Progress, 100
	Progress, Off
}