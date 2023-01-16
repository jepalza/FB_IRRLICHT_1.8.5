'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 52 : Lens Flare
'  A representation of the camera optics effect known as Lens Flare
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MD2Mesh As Integer
Dim MeshTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 52: Lens Flare - Camera Optics caught in the light" )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/flares.jpg" )

'  simply add the lens flare object and then move it to the position of the
'  lightsource that causes the effect, you may have to cast a ray out to this
'  point and see if it strikes a node that might be obscuring the light. in this
'  case you would make the lens flare invisible
SceneNode = iCreateFlare( MeshTexture )
iPositionNode( SceneNode, 300,100,1000 )

'  add a first person camera into the scene, and hide the mouse
iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 180, 225, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()
    
     '  draw the GUI
    iDrawGUI()

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
