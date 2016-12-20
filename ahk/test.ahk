Gui, +LastFound
Gui, Add, DropDownList, r5 w100
Gui, Add, Button,, AddItem
Gui, Add, Button,, InsertItem
Gui, Add, Button,, ChangeItem
Gui, Add, Button,, RemoveItem
Gui, Add, Button,, ResetItems
Gui, Add, Button,, GetAllItems
Gui, Show 
Return

GuiClose:
ExitApp

ButtonAddItem:
InputBox,addItem,Add Item
SendMessage,0x143,,&addItem,ComboBox1 ;CB_ADDSTRING
SendMessage,0x14E,%Errorlevel%,,ComboBox1 ;CB_SETCURSEL
Return

ButtonInsertItem:
InputBox,insertItem,Insert Item
SendMessage,0x147,,,ComboBox1 ;CB_GETCURSEL
OldPos := Errorlevel
SendMessage,0x14A,%Errorlevel%,&insertItem,ComboBox1 ;CB_INSERTSTRING
SendMessage,0x14E,%OldPos%,,ComboBox1 ;CB_SETCURSEL
Return

ButtonChangeItem:
InputBox,changeItem,change Item
SendMessage,0x147,,,ComboBox1 ;CB_GETCURSEL
Pos := Errorlevel
SendMessage,0x144,%Errorlevel%,,ComboBox1 ;CB_DELETESTRING
SendMessage,0x14A,%Pos%,&changeItem,ComboBox1 ;CB_INSERTSTRING
SendMessage,0x14E,%Pos%,,ComboBox1 ;CB_SETCURSEL
Return

ButtonRemoveItem:
SendMessage,0x147,,,ComboBox1 ;CB_GETCURSEL
PriorSel := Errorlevel-1
SendMessage,0x144,%Errorlevel%,,ComboBox1 ;CB_DELETESTRING
SendMessage,0x14E,%PriorSel%,,ComboBox1 ;CB_SETCURSEL
Return

ButtonResetItems:
SendMessage,0x14B,,,ComboBox1 ;CB_RESETCONTENT
Return

ButtonGetAllItems:
Result := ""
SendMessage,0x0146,,,ComboBox1 ;CB_GETCOUNT
Loop, %Errorlevel%
{
    SendMessage,0x149,% A_Index-1,,ComboBox1 ;CB_GETLBTEXTLEN
    VarSetCapacity(buffer, Errorlevel) ;prepare buffer
    SendMessage,0x148,% A_Index-1,&buffer,ComboBox1 ;CB_GETLBTEXT
    Result .= buffer "`n"
    VarSetCapacity(buffer,0) ;empty for next wheel
}
MsgBox, %Result%
Return

