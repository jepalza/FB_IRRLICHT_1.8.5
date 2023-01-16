'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 85 : Split Screen
'  This example demonstrates a split screen effect by drawing the view from two
'  cameras to the display
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
Dim FirstCamera As Integer
Dim SecondCamera As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D(800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 85: Two Camera Split Screen" )

'  add credits for the model as a static text GUI object on the display
iStaticText( "Zumlin model by Rowan  ' Sumaleth; Crawford", 4,0,200,16, IRR_GUI_NO_BORDER, IRR_GUI_NO_WRAP, 0 )

'  load a mesh this acts as a blue print for the model
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

'  play an animation sequence embeded in the mesh. MD2 models have a group of
'  preset animations for various poses and actions. this animation sequence is
'  the character standing idle
iPlayMD2Animation( SceneNode, IRR_EMAT_STAND )

'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
FirstCamera = iCreateCamera( False )
iPositionNode( FirstCamera, 50, 0, 0 )
SecondCamera = iCreateCamera( False )
iPositionNode( SecondCamera, -50, 0, 0 )

'  as the window we are opening is twice as wide as it is high all camera objects
'  are given a default aspect ratio of 0.5, however we want to draw two windows
'  side by side 200x200 so we need to set the aspect ratios of the camera to 1.0
iCameraAspectRatio( FirstCamera, 1.0 )
iCameraAspectRatio( SecondCamera, 1.0 )

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene on the left
    iActiveCamera( FirstCamera )
    iViewPort( 0,100,400,400 )
    iDrawScene()
    
     '  draw the scene on the left
    iActiveCamera( SecondCamera )
    iViewPort( 400,100,400,400 )
    iDrawScene()

     '  set the viewport back to the whole screen
    iViewPort( 0,0, 800,600 )

     '  draw the GUI
    iDrawGUI()

     '  end drawing the scene and render it
    iEndScene()
Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
