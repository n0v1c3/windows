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
Private Const VBA_FOLDER = "\vba\"
Private Const VBA_EXTENSION = ".bas"
Private Const VBA_TOOLS = "VBATools"
Private Const XLSM = ".xlsm"

' ===
' Author(s): Travis Gall and Mike Boiko
' Description: Backup all vba macros in the current application.
' ===
Public Sub VBABackup()
    Attribute VBABackup.VB_ProcData.VB_Invoke_Func = "B\n14"
    ' Define variable types
    Dim Code As CodeModule
    Dim ModuleFile As VBComponent

    ' Create directory if not found
    If Dir(ActiveWorkbook.Path & VBA_FOLDER, vbDirectory) = "" Then
        MkDir ActiveWorkbook.Path & VBA_FOLDER
    End If

    ' Loop through each module in the current workbook
    For Each ModuleFile In ActiveWorkbook.VBProject.VBComponents
        ' Don't backup blank files and only backup VBA_TOOLS when in the matching workbook
        If ModuleFile.CodeModule.CountOfLines() > 0 And (ModuleFile.CodeModule.Name <> VBA_TOOLS Or UCase(ActiveWorkbook.Name) = UCase(VBA_TOOLS & XLSM)) Then
            ' Write current module to calculated directory
            ModuleFile.Export ActiveWorkbook.Path & VBA_FOLDER & ModuleFile.CodeModule.Name & VBA_EXTENSION
        End If ' ModuleFile.CodeModule.CountOfLines() > 0 And (ModuleFile.CodeModule.Name <> VBA_TOOLS Or UCase(ActiveWorkbook.Name) = UCase(VBA_TOOLS & XLSM))
    Next ModuleFile
End Sub ' VBABackup

' ===
' Author(s): Travis Gall
' Description: Backup all vba macros in the current application.
' ===
Public Sub VBARestore()
    Attribute VBARestore.VB_ProcData.VB_Invoke_Func = "R\n14"
    ' Define variable types
    Dim FolderPath As String
    Dim ImportFile As Variant
    Dim ActiveComponents As VBComponents
    Dim CurrentComponent As VBComponent

    ' Get ActiveWorkbook Path
    FolderPath = ActiveWorkbook.Path & VBA_FOLDER

    ' Get ActiveWorkbook.VBProject VBComponents
    Set ActiveComponents = ActiveWorkbook.VBProject.VBComponents

    ' Loop through all files in the FolderPath
    ImportFile = Dir(FolderPath)
    While (ImportFile <> "")
        ' Import any files containing .bas
        If InStr(ImportFile, ".bas") > 0 Then
            ' Loop through all VBComponents in ActiveWorkbook.VBProject
            ImportModule = Left(ImportFile, Len(ImportFile) - 4)
            For Each m In ActiveComponents
                ' Module already exists in current ActiveWorkbook.VBProject
                If m.Name = ImportModule Then
                    ' Rename existing module, this is to handle import of VBATools
                    m.Name = m.Name & "_VBATOOLS_RESTORE_" & Int((9999 - 1000 + 1) * Rnd + 1000)
                    ' Import new module, this can be done without collisions due to rename
                    ActiveComponents.Import (FolderPath & ImportFile)
                    ' Remove the existing (renamed) module
                    ActiveComponents.Remove m
                    Exit For ' m
                End If ' CurrentComponent.Name = ImportModule
            Next m
        End If ' InStr(ImportFile, ".bas") > 0

        ' Next file
        ImportFile = Dir
    Wend
End Sub ' VBARestore()
