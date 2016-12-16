Attribute VB_Name = "WebScrape"
'Worksheets
Private Const SHT_SETTINGS = "Settings"
Private Const SHT_DATAPULL = "Data Pull"

'Ranges
Private Const RNG_DATA = "B:K"
Private Const RNG_STYLE = "A:K"
Private Const RNG_HEADER = "A1:K1"
Private Const RNG_WEBADDRESS = "B2"

'Internet Explorer
Private Const IE_NAME = "Internet Explorer"
Private Const IE_IMAGETAG = "td"
Private Const IE_TRTAG = "tr"
Private Const IE_TDTAG = "td"
Private Const IE_HTTP = "http:"

'Status bar messages
Private Const MSG_COUNT = "Count:"
Private Const MSG_LOADING = "Loading..."
Private Const MSG_SCRAPING = "Scraping Site Content, Please Wait..."

'Strings
Private Const SPACE = " "
Private Const BLANK = ""
Private Const SECONDS = "s"

'Data Headers/Classes
Private Const DAT1_CLASS = "unique_vehicle_id thumbnail"
Private Const DAT2_CLASS = "has_condition_report"
Private Const DAT3_CLASS = "run_number"
Private Const DAT4_CLASS = "year number"
Private Const DAT5_CLASS = "make"
Private Const DAT6_CLASS = "model"
Private Const DAT7_CLASS = "mileage number"
Private Const DAT8_CLASS = "exterior_color"
Private Const DAT9_CLASS = "vin"
Private Const DAT10_CLASS = "seller_name"
Private Const DAT11_CLASS = "view_vehicle view_detail"
Private Const DAT1_HEADER = "IMAGE"
Private Const DAT2_HEADER = "CD"
Private Const DAT3_HEADER = "RUN #"
Private Const DAT4_HEADER = "YEAR"
Private Const DAT5_HEADER = "MAKE"
Private Const DAT6_HEADER = "MODEL"
Private Const DAT7_HEADER = "MILEAGE"
Private Const DAT8_HEADER = "COLOR"
Private Const DAT9_HEADER = "VIN"
Private Const DAT10_HEADER = "CONSIGNOR"
Private Const DAT11_HEADER = "VIEW"

'Picture Row/Col Format
Private Const ROW_HEIGHT = 50 / 4 * 3
Private Const COL_WIDTH = (75 - 12) / 7 + 1
Private Const PIC_HEIGHT = 50 / 4 * 3
Private Const PIC_WIDTH = 75 / 4 * 3

'Global for Quick Exit
Private IE_Scrape As Object

'Main Macro to Scrape Website, Set to Run on Start-Up
Sub Auto_Open()
    DoEvents
    MsgBox "Begin Update..."
    
    'Update Status Bar
    Application.StatusBar = MSG_LOADING & SPACE & IE_NAME
    
    'Variables
    Dim objElement As Object
    Dim objCollection As Object
    
    'Ensure Data Sheet is Selected
    Sheets(SHT_DATAPULL).Select
    
    'Clear Old Data
    ActiveSheet.Shapes.SelectAll
    Selection.Delete
    Range(RNG_DATA).Clear
    
    'Page Up Push-Button
    ActiveSheet.Buttons.Add(Cells(1, 11).Left + 75.5, 3.75, 45, 15.75).Select
    Selection.OnAction = "PageUp"
    Selection.Characters.Text = "PgUp"
    
    'Page Down Push-Button
    ActiveSheet.Buttons.Add(Cells(1, 11).Left + 75.5, 17.5 + 3.5, 45, 15.75).Select
    Selection.OnAction = "PageDown"
    Selection.Characters.Text = "PgDn"
    
    'Update Push-Button
    ActiveSheet.Buttons.Add(Cells(1, 11).Left + 125.5, 3.75, 45, 31.5).Select
    Selection.OnAction = "Auto_Open"
    Selection.Characters.Text = "Update"
    
    'Stop Push-Button
    ActiveSheet.Buttons.Add(Cells(1, 11).Left + 175.5, 3.75, 45, 31.5).Select
    Selection.OnAction = "StopUpdate"
    Selection.Characters.Text = "Stop"
    
    'Remove Existing Formatting
    Columns(RNG_STYLE).Interior.Pattern = xlNone
    Columns(RNG_STYLE).Interior.TintAndShade = 0
    Columns(RNG_STYLE).Interior.PatternTintAndShade = 0
    
    'Format Header
    Range(RNG_HEADER).Interior.Pattern = xlSolid
    Range(RNG_HEADER).Interior.PatternColorIndex = xlAutomatic
    Range(RNG_HEADER).Interior.ThemeColor = xlThemeColorLight1
    Range(RNG_HEADER).Interior.TintAndShade = 0.499984740745262
    Range(RNG_HEADER).Interior.PatternTintAndShade = 0
    Range(RNG_HEADER).Font.Bold = True
    Range(RNG_HEADER).Font.Underline = xlUnderlineStyleSingle
    Range(RNG_HEADER).HorizontalAlignment = xlCenter
    Range(RNG_HEADER).VerticalAlignment = xlCenter
    
    'Replace Titles in Header
    Cells(1, 1) = DAT1_HEADER
    Cells(1, 2) = DAT2_HEADER
    Cells(1, 3) = DAT3_HEADER
    Cells(1, 4) = DAT4_HEADER
    Cells(1, 5) = DAT5_HEADER
    Cells(1, 6) = DAT6_HEADER
    Cells(1, 7) = DAT7_HEADER
    Cells(1, 8) = DAT8_HEADER
    Cells(1, 9) = DAT9_HEADER
    Cells(1, 10) = DAT10_HEADER
    Cells(1, 11) = DAT11_HEADER
    
    'Filter at Header
    ActiveSheet.AutoFilterMode = False
    
    'Format Data
    Columns(RNG_DATA).HorizontalAlignment = xlCenter
    Columns(RNG_DATA).VerticalAlignment = xlCenter
    
    'Freeze Panes
    ActiveWindow.SplitColumn = 0
    ActiveWindow.SplitRow = 1
    ActiveWindow.FreezePanes = True
    
    'Set Row/Col Height/Width for Image Col
    Rows().RowHeight = ROW_HEIGHT
    Columns(1).ColumnWidth = COL_WIDTH
    
    'Initialize Internet Explorer
    Set IE_Scrape = CreateObject("InternetExplorer.Application")
    IE_Scrape.Visible = False
    WebAddress = Sheets(SHT_SETTINGS).Range(RNG_WEBADDRESS)
    IE_Scrape.Navigate WebAddress
    
    'Wait for IE to be Ready
    Do While IE_Scrape.Busy
        Application.Wait DateAdd(SECONDS, 5, Now)
    Loop
    
    'Update Status Bar
    Application.StatusBar = MSG_SCRAPING
    
    'Initialize Count
    Count = 1
    
    'Get Elements from IE by Tag Name
    Set objCollection = IE_Scrape.document.getElementsByTagName(IE_TDTAG)
    
    'Loop Through Each Element
    Length = objCollection.Length - 1
    For i = 0 To Length
        'Check Element's Class Name
        Select Case UCase(objCollection(i).className)
            'Image Grab
            Case UCase(DAT1_CLASS)
                'Increase Count
                Count = Count + 1
                
                'Get Image HREF
                href = BLANK
                On Error Resume Next
                href = objCollection(i).Children(0).href
                On Error GoTo 0
                
                'HREF Exists
                If href <> BLANK Then
                    'Get Image
                    DoEvents
                    Set curPic = ActiveSheet.Pictures.Insert(href)
                    DoEvents
                    
                    'Format Image
                    curPic.ShapeRange.LockAspectRatio = msoFalse
                    curPic.Width = PIC_WIDTH
                    curPic.Height = PIC_HEIGHT
                    curPic.Top = Cells(Count, 1).Top
                    curPic.Left = Cells(Count, 1).Left
                    curPic.Placement = xlMoveAndSize
                End If
            
            'Vehicle Data
            Case UCase(DAT2_CLASS)
                Cells(Count, 2) = objCollection(i).innerText
            Case UCase(DAT3_CLASS)
                Cells(Count, 3) = objCollection(i).innerText
            Case UCase(DAT4_CLASS)
                Cells(Count, 4) = objCollection(i).innerText
            Case UCase(DAT5_CLASS)
                Cells(Count, 5) = objCollection(i).innerText
            Case UCase(DAT6_CLASS)
                Cells(Count, 6) = objCollection(i).innerText
            Case UCase(DAT7_CLASS)
                Cells(Count, 7) = objCollection(i).innerText
            Case UCase(DAT8_CLASS)
                Cells(Count, 8) = objCollection(i).innerText
            Case UCase(DAT9_CLASS)
                Cells(Count, 9) = objCollection(i).innerText
            Case UCase(DAT10_CLASS)
                Cells(Count, 10) = objCollection(i).innerText
                
            'Link to Vehicle
            Case UCase(DAT11_CLASS)
                Cells(Count, 11) = objCollection(i).innerText
                Cells(Count, 11).Hyperlinks.Add Anchor:=Cells(Count, 11), Address:=objCollection(i).Children(0).href
        End Select
        
        'Style Data Table
        If Count Mod 2 = 1 Then
            Range(Cells(Count, 1), Cells(Count, 11)).Interior.Pattern = xlSolid
            Range(Cells(Count, 1), Cells(Count, 11)).Interior.PatternColorIndex = xlAutomatic
            Range(Cells(Count, 1), Cells(Count, 11)).Interior.ThemeColor = xlThemeColorDark1
            Range(Cells(Count, 1), Cells(Count, 11)).Interior.TintAndShade = -0.249977111117893
            Range(Cells(Count, 1), Cells(Count, 11)).Interior.PatternTintAndShade = 0
        End If
        
        'Update Events (Scroll, Stop, PgUp, PgDn, ...)
        DoEvents
                
        'Update Status Bar
        Application.StatusBar = MSG_SCRAPING & SPACE & MSG_COUNT & SPACE & Count - 1
    Next 'Element
    
    'Ensure All Images are Set to Move and Size with Cells
    For Each Shape In ActiveSheet.Shapes
    Next
    
    'AutoFit Data Cols
    Columns(RNG_DATA).EntireColumn.AutoFit
    
    'Filter at Header
    ActiveSheet.AutoFilterMode = False
    Rows(1).AutoFilter
    
    'Shutdown IE
    IE_Scrape.Visible = False
    IE_Scrape.Quit
    Set IE_Scrape = Nothing
    Set objElement = Nothing
    Set objCollection = Nothing
    
    'Shutdown
    Application.StatusBar = BLANK
End Sub

'Shutdown During Opperation
Sub StopUpdate()
    On Error Resume Next
    
    'Shutdown IE
    IE_Scrape.Visible = False
    IE_Scrape.Quit
    
    'Ensure All Images are Set to Move and Size with Cells
    For Each Shape In ActiveSheet.Shapes
        Shape.Placement = xlMoveAndSize
    Next
    
    'Filter at Header
    ActiveSheet.AutoFilterMode = False
    Rows(1).AutoFilter
    
    'Shutdown
    Application.StatusBar = BLANK
    End
End Sub

'Page Up Push-Button
Sub PageUp()
    ActiveWindow.LargeScroll Up:=1
End Sub

'Page Down Push-Button
Sub PageDown()
    ActiveWindow.LargeScroll Down:=1
End Sub
