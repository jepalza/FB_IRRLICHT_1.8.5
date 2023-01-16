'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 84: GUI Functions
'  This example demonstrates the use of a range of GUI objects
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
Dim GUIEvent As Integer
Dim GUIEventID As Integer
Dim GUIEventData As Integer

Dim guiStatic As Integer
Dim guiEdit As Integer
Dim guiPassword As Integer
Dim guiWindow As Integer
Dim guiListbox As Integer
Dim redBackground As Integer = 255
Dim greenBackground As Integer = 255
Dim imageTexture As Integer
Dim fileName As String
Dim displayString As String
Dim BitmapFont As Integer

Const MY_GUI_BUTTON_FILE     = 101
Const MY_GUI_BUTTON_WINDOW   = 102
Const MY_GUI_BUTTON_QUIT     = 103
Const MY_GUI_BUTTON_CLOSE    = 104
Const MY_GUI_SCROLLBAR_RED   = 105
Const MY_GUI_SCROLLBAR_GREEN = 106
Const MY_GUI_LISTBOX         = 107
Const MY_GUI_CHECKBOX        = 108
Const MY_GUI_EDITBOX         = 109
Const MY_GUI_PASSWORD        = 110
Const MY_GUI_FILEOPEN        = 111

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface. The scene will be rendered using the Irrlicht,
'  software renderer, the display will be a window 400 x 200 pixels in size, the
'  display will not support shadows and we will not capture any keyboard and
'  mouse events and finally vertical syncronisation to smoothen the display
'  is switched on, by default it is off
iIrr3D( 512, 256, 32, False )

'  Set the title of the display
iAppTitle( "Example 84: GUI Functions" )

'  set the font used by the GUI
BitmapFont = iLoadFont ( "./media/fonthaettenschweiler.bmp" )
iGUISetFont( BitmapFont )

'  set the colors used by GUI controls
'iGUISetColor( EGDC_3D_FACE, 192, 255, 255, 255 )
iGUISetColor( EGDC_BUTTON_TEXT, 0, 64, 64, 255 )

'  add a static text object to the graphical user interface. The text will be
'  drawn inside the defined rectangle, the box will not have a border and the
'  text will not be wrapped around if it runs off the end
guiStatic = iStaticText( "Hello World", 4,0,256,16, False, False, 0 )

'  add a button to the graphical user interface
iCreateButton( 16, 16, 112, 32, MY_GUI_BUTTON_FILE, "Select File", "Select a bitmap", 0 )

'  add a couple of more buttons to the graphical user interface
iCreateButton( 128, 16, 224, 32,   MY_GUI_BUTTON_WINDOW, "Open a window", "", 0 )
iCreateButton( 240, 16, 336, 32,  MY_GUI_BUTTON_QUIT, "Close the GUI", "",0 )

'  add a horizontal scroll bar to the graphical user interface
iCreateScrollBar( IRR_GUI_HORIZONTAL, 32, 48, 320, 64, MY_GUI_SCROLLBAR_RED, 255, 255, 0 )

'  add a vertical scroll bar to the graphical user interface
iCreateScrollBar( IRR_GUI_VERTICAL, 16, 64, 32, 240, MY_GUI_SCROLLBAR_GREEN, 255, 255, 0 )

'  add a listbox to the display
guiListbox = iCreateListBox( 48, 64, 320, 128, MY_GUI_LISTBOX, IRR_GUI_DRAW_BACKGROUND, 0 )

'  add three items to the listbox
iAddGadgetItem( guiListbox, "Apples" )
iAddGadgetItem( guiListbox, "Oranges" )
iAddGadgetItem( guiListbox, "Pears" )

'  select item 1 oranges
iSelectGadgetItem( guiListbox, 1 )

'  add a normal editbox to the display
guiEdit = iCreateEditBox( "Editable text", 48,128, 320,144, MY_GUI_EDITBOX, True, False, 0 )

'  add a password editbox to the display
guiPassword = iCreateEditBox( "Hidden Password", 48,144, 320,160, MY_GUI_PASSWORD, True, True, 0 )

'  add a checkbox to the display
iCreateCheckBox( "Clickable Option", 48,160, 320,176, MY_GUI_CHECKBOX, 1, 0 )

'  Let the GUI system handle the events
' IrrGUIEvents( 1 )


'  while the scene is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene, erasing the canvas to white before rendering

	iCameraCLSColor(redBackground, greenBackground, 255 )
    iBeginScene()

     '  draw the Graphical User Interface
    iDrawGUI()

     '  if there are GUI events available
    If iGUIEventAvailable() Then

         '  read the GUI event out 
        iReadGUIEvent()
		GUIEventID = iGUIEventID()
		GUIEvent = iGUIEvent()
		GUIEventData = iGUIEventData()
		'DebugLog "ID= "+GUIEventID 

         '  process the particular control
        Select Case GUIEventID
 
        Case MY_GUI_BUTTON_FILE
             '  if the button has been pressed
            If GUIEvent = EGET_BUTTON_CLICKED Then
                 '  open a file open dialog
                iAddFileOpen( "Select an image file", MY_GUI_FILEOPEN, IRR_GUI_MODAL, 0  )
            End If

        Case MY_GUI_BUTTON_WINDOW
             '  if the button has been pressed
            If GUIEvent = EGET_BUTTON_CLICKED Then
                 '  open a small modal window
                guiWindow = iCreateWindow( "Window", 80, 80, 160, 144, IRR_GUI_MODAL, 0 )
                 '  with a button that can close the window
                iCreateButton( 16, 32, 64, 48, 104, "Close me", "", guiWindow )
            End If

        Case MY_GUI_BUTTON_QUIT
             '  if the button has been pressed
            If GUIEvent = EGET_BUTTON_CLICKED Then
                 '  all GUI elements from the display
                iGUIClear()
                 '  let the system handle mouse and key events now
                 ' IGUIEvents( 0 )
            End If

        Case MY_GUI_BUTTON_CLOSE
             '  if the button has been pressed
            If GUIEvent = EGET_BUTTON_CLICKED Then
                 '  remove the window and its child buttons from the display
                iGUIRemove( guiWindow )
            End If

        Case MY_GUI_SCROLLBAR_RED
             '  if the position of the scrollbar has been changed
            If GUIEvent = EGET_SCROLL_BAR_CHANGED Then
                 '  set the red value of the background color
                redBackground = GUIEventData
            End If

        Case MY_GUI_SCROLLBAR_GREEN
             '  if the position of the scrollbar has been changed
            If GUIEvent = EGET_SCROLL_BAR_CHANGED Then
                 '  set the red value of the background color
                greenBackground = GUIEventData
            End If

        Case MY_GUI_LISTBOX
             '  if the listbox selection has changed
            If GUIEvent = EGET_LISTBOX_CHANGED Then
                 '  change the text to show which item is selected
                If GUIEventData = 0 Then iGUISetText( guiStatic, "Selected apples" )
                If GUIEventData = 1 Then iGUISetText( guiStatic, "Selected oranges" )
                If GUIEventData = 2 Then iGUISetText( guiStatic, "Selected pears" )
            End If

        Case MY_GUI_EDITBOX
             '  if the editbox contents have changed
            If GUIEvent = EGET_EDITBOX_CHANGED Then
                 '  set the static text object to the contents of the edit box
                iGUISetText( guiStatic, iGUIGetText( guiEdit ))
            End If

        Case MY_GUI_PASSWORD
             '  if the password editbox contents have changed
            If GUIEvent = EGET_EDITBOX_CHANGED Then
                 '  set the static text object to the contents of the edit box
                iGUISetText( guiStatic, iGUIGetText( guiPassword ))
            End If

        Case MY_GUI_CHECKBOX
             '  if the checkbox state has changed
            If GUIEvent = EGET_CHECKBOX_CHANGED Then
                 '  set the static text object to represent the checkbox state
                If GUIEventData = 0 Then
                    iGUISetText( guiStatic, "Checkbox is Cleared" )
                Else
                    iGUISetText( guiStatic, "Checkbox is Checked" )
                End If
            End If

        Case MY_GUI_FILEOPEN
             '  if the event was from a file being selected
            If GUIEvent = EGET_FILE_SELECTED Then
				'DebugLog iGetLastSelectedFile()
                imageTexture = iLoadTexture( iGetLastSelectedFile() )
                If Not imageTexture = 0 Then
                    iStaticImage( imageTexture, 352, 16, True, 140, 0 )
                End If
            End If

        End Select
    End If

     '  end drawing the scene and render it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
