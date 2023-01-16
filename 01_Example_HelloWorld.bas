'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 01: Hello World
'  This simple example opens an Irrlicht window and displays the text
'  Hello World on the screen and waits for the user to close the application
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  ////////////////////////////////////////////////////////////////////////////
'  -----------------------------------------------------------------------------
'  start the irrlicht interface. The scene will be rendered using the Irrlicht,
'  software renderer, the display will be a window 400 x 200 pixels in size, the
'  display will not support shadows and we will not capture any keyboard and
'  mouse events and finally vertical syncronisation to smoothen the display
'  is switched on, by default it is off
iIrr3D( 640, 480, 32, False )

'  Set the title of the display
iAppTitle( "Example 01: Hello World" )

'  add a static text object to the graphical user interface. The text will be
'  drawn inside the defined rectangle, the box will not have a border and the
'  text will not be wrapped around if it runs off the end
iStaticText( "Hello World", 4,0,200,16, IRR_GUI_NO_BORDER, IRR_GUI_NO_WRAP ,0)

'  erase the canvas to white before rendering
iCameraCLSColor( 255, 255, 255 )

'  while the scene is still running
While iRun() And (Not iKeyHit(KEY_ESCAPE))
     '  begin the scene
    iBeginScene()

     '  draw the Graphical User Interface
    iDrawGUI()

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
