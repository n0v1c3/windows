' ===
' Author(s): Travis Gall and Mike Boiko
' Description: Backup all vba macros in the current application. The subroutine
'              "Workbook_BeforeSave" will run automatically when the project containing
'              the macro is saved.
' ===

' TODO [161215] - Create a subroutine or function capable of importing a previous backup into the current project

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

Private Const CODE_START_LINE_DEFAULT = 1
Private Const VBA_FOLDER = "/vba/"
Private Const VBA_EXTENSION = ".vba"

' Triggered automatically on user save event and used to create a backup of the current workbook's vba as plain-text
Private Sub Workbook_BeforeSave(ByVal SaveAsUI As Boolean, Cancel As Boolean)
    ' ===
    ' Debug
    ' ===

    ' Define types
    Dim DebugEnabled As Boolean

    ' Enable/disable debugging here
    DebugEnabled = False

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
    
    ' TODO [161215] - Clean up old vba backups prior to saving the current modules
    
    ' Get current workbook path
    FolderPath = Application.ActiveWorkbook.Path & VBA_FOLDER
    
    ' Skip current module if empty
    If Dir(FolderPath, vbDirectory) = "" Then MkDir FolderPath
    
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
        If CodeLineCount < CODE_START_LINE_DEFAULT Then GoTo NextModule
        
        ' Filepath of current module
        FilePath = FolderPath & Code.Name & VBA_EXTENSION
        
        ' ---
        ' Write
        ' ---
        
        ' Open file by file path
        Open FilePath For Output As #1
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
End Sub ' Workbook_BeforeSave
