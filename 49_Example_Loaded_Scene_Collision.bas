'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 49 : Collision in a Loaded IrrEdit Scene
'  This example demonstrates collision in a scene that was created in IrrEdit
'  the nodes in the scene are found and then collision selection objects are
'  created for them in the same way as you would with a custom created scene
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
Dim NodeGround As Integer
Dim NodeBox As Integer
Dim SelectorGround As Integer
Dim SelectorBox As Integer
Dim CombinedCollision As Integer
Dim CollisionAnimator As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800,600, 32, False )

'  send the window caption
iAppTitle( "Example 49: Collision in a Loaded Scene" )

'  load an example scene created in irrEdit
iLoadScene( "./media/CollisionScene.irr" )

'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 200, 100, 0 )
iRotateNode( CameraNode, 0, -90, 0 )

'  first we need to get references to the objects in the scene that the viewer
'  can collide with
NodeGround = iGetNodeByName( "Ground" )
NodeBox = iGetNodeByName( "Pillar" )

'  next we need to create collision objects from the nodes 
SelectorGround = iGetCollisionGroupFromBox( NodeGround )
SelectorBox = iGetCollisionGroupFromBox( NodeBox )

'  now that we have collision objects for each of the nodes we need to combine
'  them into a collision group
CombinedCollision = iCreateCombinedCollisionGroup ()

'  creates a meta-selector that is a group of selector objects
iAddCollisionGroupToCombination ( CombinedCollision, SelectorGround )
iAddCollisionGroupToCombination ( CombinedCollision, SelectorBox )

'  finally we add a collision animator to the camera, this constrains the camera
'  so that its movement is restricted by collision with the collision groups we
'  just created. the parameters we supply are as follows: -
'        The collision objects, the node to be effected by collision,
'        x, y and z radius of the collision area,
'        x, y and z force of gravity to apply to the node affected by collision,
'        x, y and z offset of the node
CollisionAnimator = iCollisionAnimator(CombinedCollision, CameraNode,30.0,30.0,30.0,0.0,-3.0,0.0,0.0,50.0,0.0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 200, 200, 255 )

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
