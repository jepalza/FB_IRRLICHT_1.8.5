'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 110 : Fade Animator
'  The fade animator slowly fades a node out and resizes it over a period of
'  time before finally deleting it
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
iAppTitle( "Example 110: Fade Node Animator" )

'  add credits for the model as a static text GUI object on the display
iStaticText( "Zumlin model by Rowan  ' Sumaleth; Crawford", 4,0,200,16, IRR_GUI_NO_BORDER, IRR_GUI_NO_WRAP, False )

'  load a mesh and add to the scene as a new node
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, True )

'  play an animation sequence embeded in the mesh. MD2 models have a group of
'  preset animations for various poses and actions. this animation sequence is
'  the character standing idle
iPlayMD2Animation( SceneNode, IRR_EMAT_STAND )

'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 50, 0, 0 )

'  set the ambient light level across the entire scene
iAmbientLight( 1,1,1 )

'  Add the fade, scale and delete animator
'  fade the node out over 3000ms and increase its size by 25 As Integer
iFadeAnimator( SceneNode, 3000, -1.0 )

' , erase the canvas with sky-blue before rendering
iCameraCLSColor( 240, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  begin the scene, erasing the canvas with sky-blue before rendering
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
