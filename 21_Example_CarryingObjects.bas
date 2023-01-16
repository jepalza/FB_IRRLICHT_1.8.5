'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 21 : Carrying Objects
'  This example demonstrates how you can attach a child model to an animated
'  Direct X model containing joints
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim BoxTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer
Dim JointNode As Integer
Dim TestNode As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 21: Carrying Objects" )

'  load a mesh, when loading a .x file the textures will be automatically loaded
'  and applied to the model
SceneNode = iLoadAnimMesh( "./media/dwarf.x", False )

'  switch off lighting effects on this model
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

'  set the speed of playback for the animated Direct X model
iAnimationSpeed( SceneNode, 2000 )

'  add a camera into the scene pointing at the model
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 75, 40, -150 )
iCameraTarget( OurCamera, 0, 40, 0 )

'  create a test node to represent the object that is being carried
TestNode = iCreateCube( 16, False )

'  load texture resources for texturing the box
BoxTexture = iLoadTexture( "./media/texture.jpg" )

'  assign a texture to the carried object
iNodeTexture( TestNode, BoxTexture, 0 )

'  switch off lighting effects on the test box
iNodeMaterialFlag( TestNode, IRR_EMF_LIGHTING, False )

'  offset the position of the node so that it appears to be attached to the
'  characters hand
iPositionNode( TestNode, 20,-15,-10 )

'  get an invisible node that is attached to the specified joint on the animated
'  node
JointNode = iGetNodeJoint( SceneNode, "Joint16" )

'  attach the carried test node to this invisible joint node from now on the
'  carried object will move along with the joint without any more intervention
'  from us
iNodeParent ( TestNode, JointNode )

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
