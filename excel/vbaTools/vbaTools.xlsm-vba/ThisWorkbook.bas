VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Private Sub Workbook_Open()
    'Dim fso As Object
    'Set fso = VBA.CreateObject("Scripting.FileSystemObject")
    'Windows("vbaTools.xlsm").Visible = True
    'fso.CopyFile Windows("vbaTools.xlsm").Application.ActiveWorkbook.Path & "\vbaTools.exportedUI", "C:\Users\" & Environ("username") & "\AppData\Local\Microsoft\Office\Excel.officeUI"
    Windows("vbaTools.xlsm").Visible = False
End Sub
