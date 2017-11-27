Attribute VB_Name = "ExcelTools"
' ===
' Author(s): Travis Gall and Mike Boiko
' Description: A bundle of tools to help with Excel development.
' ===

' ===
' Author(s): Mike Boiko
' Description: Paste values into current selection (AKA Ctrl+Shift+V)
' ===
Public Sub PasteValues()
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
End Sub

' ===
' Author(s): Travis Gall
' Description: Toggle horizontal alignment between center and general
' ===
Public Sub FormatCenter()
Attribute FormatCenter.VB_ProcData.VB_Invoke_Func = "e\n14"
    Selection.HorizontalAlignment = IIf(Selection.HorizontalAlignment = xlCenter, xlGeneral, xlCenter)
End Sub
