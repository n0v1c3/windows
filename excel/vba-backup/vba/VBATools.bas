Attribute VB_Name = "VBATools"
' ===
' Author(s): Travis Gall and Mike Boiko
' Description: A bundle of tools to help with VBA development.
' ===

' ===
' Install
' ===

' - Copy this code into "ThisWorkbook" on any projects you wish to enable the plain text backup
' - Enable "Microsoft Visual Basic for Applications Extensibility 5.x"
'   -> Tools>References
'   -> Find "... 5.x" and check to enable
'   -> "OK"
' - Enable "Programmatic access to Office VBA project"
'   -> Open Office application settings
'   -> Navigate to "Trust Center/Trust Center Settings"
'   -> Within "Macro Settings" enable "Trust access to the VBA project object model"
'
' In order for auto-save Macro to work, Application.EnableEvents needs to be True

' ===
' Constants
' ===
Private Const MODULE_NAME = "VBATools" ' Update manually (see first line) when changing for next import
Private Const DEBUG_ENABLED = False
Private Const CODE_START_LINE_DEFAULT = 1
Private Const VBA_FOLDER = "/vba/"
Private Const VBA_EXTENSION = ".bas"

' ---
' Author(s): Travis Gall and Mike Boiko
' Description: Backup all vba macros in the current application.
' ---
Private Sub VBABackup()
    ' ===
    ' Debug
    ' ===

    ' Define types
    Dim DebugEnabled As Boolean

    ' Enable/disable debugging here
    DebugEnabled = False Or DEBUG_ENABLED

    ' ===
    ' Main
    ' ===

    ' Define variable types
    Dim Code As CodeModule
    Dim CodeLine As Long
    Dim CodeLineCount As Long
    Dim FilePath As String
    Dim FolderPath As String
    Dim ModuleFile As VBComponent
    Dim ModuleName As String

    ' Get current workbook path
    FolderPath = Application.ActiveWorkbook.Path & VBA_FOLDER

    ' Skip current module if empty
    If Dir(FolderPath, vbDirectory) = "" Then
        MkDir FolderPath
    End If

    ' ---
    ' Modules
    ' ---

    ' Loop through each module in the current workbook
    For Each ModuleFile In ActiveWorkbook.VBProject.VBComponents
        ' ---
        ' Read
        ' ---

        ' Get the code object from the current module in the loop
        Set Code = ModuleFile.CodeModule

        ' Number of lines in the code
        CodeLineCount = Code.CountOfLines()

        ' No need to write blank modules
        If CodeLineCount < CODE_START_LINE_DEFAULT Then
            GoTo NextModule
        End If

        ' Filepath of current module
        FilePath = FolderPath & Code.Name & VBA_EXTENSION

        ' ---
        ' Write
        ' ---

        ' Open file by file path
        Open FilePath For Output As #1
        Print #1, "Attribute VB_Name = """ & MODULE_NAME & """"
        ' Print current module code to the open vba file
        Print #1, Code.Lines(CODE_START_LINE_DEFAULT, CodeLineCount)
        Close #1 ' Close file

        ' * Debug Output
        If DebugEnabled Then
            ' Display the output of the current module
            Debug.Print Code.Lines(CODE_START_LINE_DEFAULT, CodeLineCount)
        End If

        ' Skip to this label when CodeLineCount < CODE_START_LINE_DEFAULT
NextModule:

    Next ModuleFile
End Sub ' VBABackup

' ---
' Author(s): Travis Gall
' Description: Backup all vba macros in the current application.
' ---
Private Sub VBARestore()
    wb.VBProject.VBComponents.Import ("C:\Program Files (x86)\Microsoft Office\Office14\Library\SingleProperty.bas")

    Dim MyObj As Object, MySource As Object, file As Variant
    file = Dir("c:\testfolder\")
    While (file <> "")
        If InStr(file, "test") > 0 Then
            MsgBox "found " & file
            Exit Sub
        End If
        file = Dir
    Wend
End Sub ' VBARestore()
