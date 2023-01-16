
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

iIrr3D( 640, 480, 32, False )

'iUseDirect3D9()
'iUseOpenGL()

' Set the title of the display
iAppTitle( "Example 01: Hello World" )

' add a static text object to the graphical user interface. The text will be
' drawn inside the defined rectangle, the box will not have a border and the
' text will not be wrapped around if it runs off the end
iStaticText( "Hello World", 4,0,200,16, IRR_GUI_NO_BORDER, IRR_GUI_NO_WRAP ,0)


' erase the canvas to white before rendering
iCameraCLSColor( 255, 255, 255 )


' =========================
' ejemplo de musica de fondo
iKlangInit()
' params: nombre, looped ,paused, track, mode, fx
iPlaySound("media\getout.ogg",1,0,1,1,1)
'==========================

' while the scene is still running
While iRun() And (Not iKeyHit(KEY_ESCAPE))
    ' begin the scene
    iBeginScene()

    ' draw the Graphical User Interface
    iDrawGUI()

    ' end drawing the scene and render it
    iEndScene()
Wend

' -----------------------------------------------------------------------------
' Stop the irrlicht engine and release resources
iEndIrr3D()

End