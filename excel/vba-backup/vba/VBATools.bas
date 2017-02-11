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
Private Const DEBUG_ENABLED = False
Private Const VBA_FOLDER = "\vba\"
Private Const VBA_EXTENSION = ".bas"

' ===
' Author(s): Travis Gall and Mike Boiko
' Description: Backup all vba macros in the current application.
' ===
Public Sub VBABackup()
    ' ===
    ' Main
    ' ===
    ' Define variable types
    Dim Code As CodeModule
    Dim CodeLineCount As Long
    Dim FilePath As String
    Dim FolderPath As String
    Dim ModuleFile As VBComponent

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
        If CodeLineCount < 1 Then
            GoTo NextModule
        End If

        ' Filepath of current module
        FilePath = FolderPath & Code.Name & VBA_EXTENSION

        ' ---
        ' Write
        ' ---
        ' Open file by file path
        Open FilePath For Output As #1
        Print #1, "Attribute VB_Name = """ & Code.Name & """"
        ' Print current module code to the open vba file
        Print #1, Code.Lines(1, CodeLineCount)
        Close #1 ' Close file

        ' Skip to this label when CodeLineCount < 1
NextModule:

    Next ModuleFile
End Sub ' VBABackup

' ===
' Author(s): Travis Gall
' Description: Backup all vba macros in the current application.
' ===
Public Sub VBARestore()
    ' ===
    ' Main
    ' ===
    ' Define variable types
    Dim FolderPath As String
    Dim ImportFile As Variant
    Dim ActiveComponents As VBComponents
    Dim CurrentComponent As VBComponent
    
    ' Get ActiveWorkbook Path
    FolderPath = ActiveWorkbook.Path & VBA_FOLDER
    
    ' Get ActiveWorkbook.VBProject VBComponents
    Set ActiveComponents = ActiveWorkbook.VBProject.VBComponents
    
    ' Skip current module if empty
    If Dir(FolderPath, vbDirectory) = "" Then
        MkDir FolderPath
    End If
    
    ' Loop through all files in the FolderPath
    ImportFile = Dir(FolderPath)
    While (ImportFile <> "")
        ' Import any files containing .bas
        If InStr(ImportFile, ".bas") > 0 Then
            ' Loop through all VBComponents in ActiveWorkbook.VBProject
            ImportModule = Left(ImportFile, Len(ImportFile) - 4)
            'If ImportModule <> "VBATools" Then
                For Each m In ActiveComponents
                    ' Module already exists in current ActiveWorkbook.VBProject
                    If m.Name = ImportModule Then
                        ' Remove exiting module
                        m.Name = m.Name & "_OLD"
                        ActiveComponents.Import (FolderPath & ImportFile)
                        ActiveComponents.Remove m
                        Exit For ' m
                    End If ' CurrentComponent.Name = ImportModule
                Next m
            'End If ' ImportModule <> "VBATools"
        End If ' InStr(ImportFile, ".bas") > 0
        ' Next file
        ImportFile = Dir
    Wend
End Sub ' VBARestore()
