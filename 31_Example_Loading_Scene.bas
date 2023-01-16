'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 31 : Loading an IrrEdit Scene
'  This example loads a scene created with the IrrEdit tool this allows a large
'  number of meshes, textures and nodes to be loaded and created in one call
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Camera As Integer
Dim CameraNode As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 31: Loading a scene" )

'  load an example scene created in irrEdit
iLoadScene( "./media/SimpleScene.irr" )

'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 60, 0, 0 )
iRotateNode( CameraNode, 0, -90, 0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

iCameraCLSColor( 140, 255, 255 )
'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene, erasing the canvas with sky-blue before rendering
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
