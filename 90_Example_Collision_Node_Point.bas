'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 90 : Getting the point of collision
'  This example gets the acurate point of collision between the triangles of a
'  node and a ray we cast out into the scene through the center of the camera
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
Dim TestTexture As Integer
Dim SceneNode As Integer
Dim TestNode As Integer
Dim OurCamera As Integer
Dim CollisionGroup As Integer
Dim StartVectorX As Single
Dim StartVectorY As Single
Dim StartVectorZ As Single
Dim EndVectorX As Single
Dim EndVectorY As Single
Dim EndVectorZ As Single

'  ////////////////////////////////////////////////////////////////////////////
'  -----------------------------------------------------------------------------
'  start the irrlicht interface
iVSync( True )
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 90: Getting the node and point of collision" )

'  load a mesh
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )

'  load texture resources for texturing models
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )
TestTexture = iLoadTexture( "./media/texture.jpg" )

'  add a test node to the scene, we are going to use this test node as the
'  marker for the point that is detected by the collision
TestNode = iCreateCube( 8, False )

'  rescale the node so that it is an unobtrusive size
iScaleNode( TestNode, 0.2, 0.2, 0.2 )
iNodeMaterialFlag( TestNode, IRR_EMF_LIGHTING, False )

'  apply materials to the objects
iNodeTexture( SceneNode, MeshTexture, 0 )
iNodeTexture( TestNode, TestTexture, 0 )

'  switch off lighting effects on the model
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

'  stop the animation playing
iAnimateNode( SceneNode, 0, 0.0, 0, 0, 1.0)
' inodeAnimationRange( SceneNode, 0,0)

'  add a first person camera into the scene and point it at the model
OurCamera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )
iPositionNode( OurCamera, 50,0,0 )
iCameraTarget( OurCamera, 0,0,0 )

'  create a simple collision group from the triangles containing within the
'  bounding box of the model
CollisionGroup = iGetCollisionGroupFromMesh( SceneNode, 0 )

'  hide the mouse from the display so we can see things better
iHideMouse()

Dim nodeHit As Integer = 0

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

	StartVectorX = iNodeX( OurCamera, False )
	StartVectorY = iNodeY( OurCamera, False )
	StartVectorZ = iNodeZ( OurCamera, False )
	
	EndVectorX = iCameraTargetX( OurCamera )
	EndVectorY = iCameraTargetY( OurCamera )
	EndVectorZ = iCameraTargetZ( OurCamera )
    
     '  extend the line through the target point for 5000 times its origonal length
    EndVectorX = EndVectorX + ((EndVectorX - StartVectorX) * 5000)
    EndVectorY = EndVectorY + ((EndVectorY - StartVectorY) * 5000)
    EndVectorZ = EndVectorZ + ((EndVectorZ - StartVectorZ) * 5000)

     '  using the line we have defined and the collision group created from the
     '  object get the node and point at which the two collide
    nodeHit = iLinePick ( StartVectorX, StartVectorY, StartVectorZ, EndVectorX, EndVectorY, EndVectorZ )
	
    If Not nodeHit = False Then 
        iNodeMaterialFlag( nodeHit, IRR_EMF_LIGHTING, False )
    Else 
        iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, True )
    End If 

     '  move the test object to this location to indicate the point of collision
    iPositionNode( TestNode, iPickedX(),iPickedY(),iPickedZ() )

     '  draw the scene
    iDrawScene()
    
     '  end drawing the scene and render it
    iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
