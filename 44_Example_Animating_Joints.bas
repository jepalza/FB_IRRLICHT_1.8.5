'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 44 : Manually Animating Bones
'  This example loads an animated model containing bones and then adjusts one of
'  those bones through programming
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
Dim AnimatedNode As Integer
Dim JointNode As Integer
Dim OurCamera As Integer
Dim rotation As Single = 0.0

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 1024, 768, 32, False )

'  set the window caption
iAppTitle( "Example 44: Manually Animating Bones" )

'  add credits for the model as a static text GUI object on the display
iStaticText( "Dwarf model by Yagodib, many thanks", 4,0,200,16, IRR_GUI_NO_BORDER, IRR_GUI_NO_WRAP, 0 )

'  load a mesh this acts as a blue print for the model
AnimatedNode = iLoadAnimMesh( "./media/dwarf.x", False )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( AnimatedNode, IRR_EMF_LIGHTING, False )

'  ensure that the bone can be controlled programmatically
iSetJointMode( AnimatedNode, IRR_JOINT_MODE_CONTROL )

'  get the bone node
JointNode = iGetNodeJoint( AnimatedNode, "Joint4" )

If JointNode = False Then
   Print "Unable to get joint node" 
	Sleep:end
End If

'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 75, 30, 0 )
iCameraTarget( OurCamera, 0, 30, 0 )

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 240, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     ' Animates the mesh based on the position of the joints, this should be used at
     ' the end of any manual joint operations including blending and joints animated
     ' using IRR_JOINT_MODE_CONTROL and iRotateNode on a bone node
    iAnimateJoints( AnimatedNode )

     '  rotate the node
    iRotateNode( JointNode, rotation, 0.0, 0.0 )
    rotation = rotation - 1


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
