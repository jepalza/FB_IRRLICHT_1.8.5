'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 107 : Render to texture with alpha
'  This example demonstrates rendering to a texture while using the alpha
'  channel to create shaped and animated HUD elements
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MeshTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer
Dim TextureCamera As Integer
Dim Texture As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 107: Render to texture with alpha" )

'  load a mesh this acts as a blue print for the model
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )

'  make sure that vertex color do not affect any lighting
iNodeColorByVertex( SceneNode, ECM_NONE )

'  set up some lighting colors
iNodeAmbientColor( SceneNode, iMakeARGB( 255,0,0,255 ))
iNodeDiffuseColor( SceneNode, iMakeARGB( 64,255,96,255 ))
iNodeSpecularColor( SceneNode, iMakeARGB( 255,255,0,255 ))
iNodeEmissiveColor( SceneNode, iMakeARGB( 0,0,0,255 ))

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  play an animation sequence embeded in the mesh. MD2 models have a group of
'  preset animations for various poses and actions. this animation sequence is
'  the character standing idle
iPlayMD2Animation( SceneNode, IRR_EMAT_STAND )

'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
TextureCamera = iCreateCamera( False )
iPositionNode( TextureCamera, 50, 0, 0 )
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 50, 0, 0 )

'  add a  light source
iCreateLight( False, 100,100,-100, 0.9,0.9,0.9, 600.0 )

'  add some ambient lighting
iAmbientLight( 0.1, 0.1, 0.1 )

'  create a surface for rendering the image to
Texture = iCreateRenderTexture( 128, 128 )

'  circle the camera around the object
iFlyCircleAnimator( OurCamera, 0.0, 0.0, 0.0, 40.0, 0.001 )

iCameraCLSColor( 128, 128, 192 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  render to a texture
        iRenderTargetTexture( Texture, iMakeARGB( 128,0,0,0), True, True )

         '  switch to the texture camera
        iActiveCamera( TextureCamera )

         '  draw the scene to the texture
        iDrawScene()

         '  set the render target back to the screen
        iRenderTargetTexture( 0, 0, False, False )

         '  switch to the display camera
        iActiveCamera( OurCamera )

         '  begin the scene, erasing the canvas with sky-blue before rendering
        iBeginScene()

         '  draw the scene
        iDrawScene()

         '  draw a the texture with the alpha channel to the screen
        iDrawImageElement( Texture, 4, 4, 0, 0, 128, 128, True )

         '  end drawing the scene and render it
        iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
