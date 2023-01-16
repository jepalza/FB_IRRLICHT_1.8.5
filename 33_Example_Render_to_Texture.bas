'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 33 : Rendering to a texture
'  This example renders a 3D model and a cube to the scene and uses the 3D model
'  to texture the cube.
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
Dim RenderTexture As Integer
Dim TextureA As Integer
Dim TextureB As Integer
Dim SceneNode As Integer
Dim CubeNode As Integer
Dim StaticCamera As Integer
Dim FPSCamera As Integer
Dim pixels As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 33: Rendering to a texture" )

'  add credits for the model as a static text GUI object on the display
iStaticText( "Zumlin model by Rowan  ' Sumaleth; Crawford", 4,0,200,16, False, False, False )

'  load a mesh this acts as a blue print for the model
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )

'  create a texture surface that is suitable for rendering a display onto
'  the renderview must be the same size or larger than this texture
RenderTexture = iCreateRenderTexture ( 128, 128 )
TextureA = iLoadTexture( "./media/Diagonal.bmp" )
TextureB = iCreateTexture( "merged", 128, 128, ECF_A8R8G8B8 )

'  add a simple cube to the scene that will be textured with the rendered surface
CubeNode = iCreateCube( 30.0, False )
iPositionNode( CubeNode, 0, 0, 100 )

'  apply a material to the nodes to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )
iNodeTexture( CubeNode, RenderTexture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )
iNodeMaterialFlag( CubeNode, IRR_EMF_LIGHTING, False )

'  play an animation sequence embeded in the mesh. MD2 models have a group of
'  preset animations for various poses and actions. this animation sequence is
'  the character standing idle
iPlayMD2Animation( SceneNode, IRR_EMAT_STAND )

'  add a static camera that is used to render the scene to a texture
StaticCamera = iCreateCamera( False )
iPositionNode( StaticCamera,50,0,0 )

'  add a first person camera that is used for the display view
FPSCamera = iCreateFPSCamera( False,100.0,0.5,-1,0,0,0,0.0)
iPositionNode( FPSCamera, 40, 0, 110 )
iCameraTarget( FPSCamera, 0,0,80 )
' iRotateNode( FPSCamera, 160, -400.0, 0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 140, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  switch to the static camera and render the scene to the texture
    iActiveCamera ( StaticCamera )


    pixels = iLockTexture( RenderTexture )
    iDrawSceneToTexture( RenderTexture )
    iUnlockTexture( RenderTexture )


     '  begin the scene
    iBeginScene()

     '  switch to the FPS camera draw the scene
    iActiveCamera ( FPSCamera )
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
