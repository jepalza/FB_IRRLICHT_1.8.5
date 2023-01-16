'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 12 : Collision
'  This example demonstrates the final animator the collision animator and how
'  to make one node collide against another. In this example we collide the
'  camera node against a BSP map allowing us to walk around the map naturally
'  there are a couple of holes in this map as the textures are not available
'  to load the polygons. see if you can escape through the bottom of the screen
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim BSPMesh As Integer
Dim BSPNode As Integer
Dim Camera As Integer
Dim CameraNode As Integer
Dim MapCollision As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 12: Collision" )

'  first we load the example map into the scene for details on this please
'  read example 5
iAddZipFile( "./media/map-20kdm2.pk3", IRR_IGNORE_CASE, IRR_IGNORE_PATHS, "" )
BSPMesh = iLoadOctreeMesh( "20kdm2.bsp" )
BSPNode = iAddOctreeMeshNode( BSPMesh )

'  next we add a first person perspective camera to the scene
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  and move it into the middle of the map
iPositionNode( Camera, 1750, 149, 1369 )
iRotateNode( Camera, 4, -461.63, 0 )


'  the first thing we need to do with collision is to create an object called a
'  selector that contains a selection of triangle to be used in the collision
'  calculations there are a number of different ways of doing this depending on
'  the type of mesh you are working with. in this example we are using the
'  complex BSP map and therefore should use the following command
MapCollision = iGetCollisionGroupFromComplexMesh( BSPMesh, BSPNode,0 )


'  now we can add the sixth and final animator to our camera object the collision
'  animator. This takes a long list of parameters that define the following :-
'  1) the collision object created from the map
'  2) the node that is going to be collided against the map
'  3) 3 vaues defining the radius of the node (the camera in this case). if you
'     make this value too small you wont be able to climb steps, if its too big
'     you might get stuck in a doorway or be able to jump over a wall. the best
'     thing to do is to have some fun experimenting
'  4) 3 values defining the pull of gravity, in this case a weak downward force
'  5) finally 3 values defining the offset of the node from the collision point
'     this will enable you to bring an object to the surface
iCollisionAnimator( MapCollision,Camera,30.0,30.0,30.0,0.0,-9.8,0.0,0.0,50.0,0.0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

' , erasing the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit(KEY_ESCAPE))

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
