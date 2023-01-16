'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 09 : Skybox
'  This example adds a skybox around the whole scene that makes a backdrop
'  for your scene to be rendered against
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Camera As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800,600, 32, False )

'  send the window caption
iAppTitle( "Example 09: Skybox" )

'  the skybox is a simple hollow cube that surrounds the whole scene. textures
'  are applied to all of the six sides of the cube creating an image around the
'  entire scene instead of simply the color of the blank canvas
'  here we load the textures as parameters of the skybox command (they could
'  of course be loaded seperatly and assigned to irr_texture variables
Dim As Integer SB_Front = iLoadTexture("./media/irrlicht2_ft.jpg")
Dim As Integer SB_Back = iLoadTexture("./media/irrlicht2_bk.jpg")
Dim As Integer SB_Left = iLoadTexture("./media/irrlicht2_lf.jpg")
Dim As Integer SB_Right = iLoadTexture("./media/irrlicht2_rt.jpg")
Dim As Integer SB_Up = iLoadTexture("./media/irrlicht2_up.jpg")
Dim As Integer SB_Down = iLoadTexture("./media/irrlicht2_dn.jpg")
Dim As Integer SkyBox = iCreateSkybox(SB_Up,SB_Down,SB_Right,SB_Left,SB_Front,SB_Back)

'  we add a first person perspective camera to the scene so you can look about
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  hide the mouse pointer
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 240, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and render it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
