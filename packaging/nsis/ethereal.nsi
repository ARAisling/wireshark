;
; ethereal.nsi
;
; $Id: ethereal.nsi,v 1.1 2001/04/04 04:50:05 gram Exp $

; ============================================================================
; Header configuration
; ============================================================================
; The name of the installer
Name "Ethereal"

; The file to write
OutFile "ethereal-setup.exe"

; Icon of installer
Icon "..\..\image\ethereal.ico"

; Uninstall stuff
UninstallText "This will uninstall Etheral. Hit 'Next' to continue."
UninstallExeName "uninstall.exe"

; ============================================================================
; License page configuration
; ============================================================================
LicenseText "Ethereal is distributed under the GNU General Public License."
LicenseData "GPL.txt"

; ============================================================================
; Component page configuration
; ============================================================================
ComponentText "Choose which components to install."
InstType Default
InstType Complete

; ============================================================================
; Directory selection page configuration
; ============================================================================
; The text to prompt the user to enter a directory
DirText "Choose a directory in which to install Ethereal."

; The default installation directory
InstallDir $PROGRAMFILES\Ethereal\

; See if this is an upgrade; if so, use the old InstallDir as default
InstallDirRegKey HKEY_LOCAL_MACHINE SOFTWARE\Ethereal "InstallDir"


; ============================================================================
; Install page configuration
; ============================================================================
ShowInstDetails show


; ============================================================================
; Installation execution commands
; ============================================================================

Section "-Required"
;-------------------------------------------
SetOutPath $INSTDIR
File "..\..\wiretap\wiretap-0.0.dll"
File "c:\program files\common files\GNU\iconv-1.3.dll"
File "c:\program files\common files\GNU\glib-1.3.dll"
File "c:\program files\common files\GNU\gmodule-1.3.dll"
File "c:\program files\common files\GNU\gnu-intl.dll"
File "..\..\README"
File "..\..\README.win32"

; Write the uninstall keys for Windows
WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal" "DisplayName" "Ethereal"
WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal" "UninstallString" '"$INSTDIR\uninstall.exe"'


Section "Ethereal"
;-------------------------------------------
SectionIn 1,2
SetOutPath $INSTDIR
File "..\..\ethereal.exe"
File "..\..\doc\ethereal.html"
File "c:\program files\common files\GNU\gtk-1.3.dll"
File "c:\program files\common files\GNU\gdk-1.3.dll"

Section "Tethereal"
;-------------------------------------------
SectionIn 1,2
SetOutPath $INSTDIR
File "..\..\tethereal.exe"
File "..\..\doc\tethereal.html"

Section "Editcap"
;-------------------------------------------
SectionIn 1,2
SetOutPath $INSTDIR
File "..\..\editcap.exe"
File "..\..\doc\editcap.html"


Section "Plugins"
SectionIn 1,2
;-------------------------------------------
SetOutPath $INSTDIR\plugins\0.8.16
File "..\..\plugins\gryphon\gryphon.dll"
File "..\..\plugins\mgcp\mgcp.dll"

Section "Debug PDB Files"
;-------------------------------------------
SectionIn 2
SetOutPath $INSTDIR
File "..\..\ethereal.pdb"
File "..\..\tethereal.pdb"
File "..\..\editcap.pdb"

Section "Start Menu Shortcuts"
;-------------------------------------------
SectionIn 1,2
CreateDirectory "$SMPROGRAMS\Ethereal"
CreateShortCut "$SMPROGRAMS\Ethereal\Ethereal.lnk" "$INSTDIR\ethereal.exe" "" "$INSTDIR\ethereal.exe" 0
CreateShortCut "$SMPROGRAMS\Ethereal\Ethereal Documentation.lnk" "$INSTDIR\ethereal.html" "" "$INSTDIR\ethereal.html" 0
CreateShortCut "$SMPROGRAMS\Ethereal\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0


Section "Uninstall"
;-------------------------------------------
DeleteRegKey HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\Ethereal"
DeleteRegKey HKEY_LOCAL_MACHINE SOFTWARE\Ethereal

Delete "$INSTDIR\README*"
Delete "$INSTDIR\*.exe"
Delete "$INSTDIR\*.pdb"
Delete "$INSTDIR\*.html"
Delete "$INSTDIR\*.dll"
Delete "$INSTDIR\plugins\0.8.16\*.dll"
Delete "$SMPROGRAMS\Ethereal\*.*"

RMDir "$SMPROGRAMS\Ethereal"
RMDir "$INSTDIR\plugins\0.8.16"
RMDir "$INSTDIR\plugins"
RMDir "$INSTDIR"

