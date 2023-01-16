'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 99: XEffects Dynamic Shadows
'  This example demonstrates the use of the XEffects module to display dynamic
'  shadows. XEffects requires shader support on the graphics card.
' 
'  This example uses a temple object that has a radiosity rendered lightmap
'  added to it as a texture, this already gives it a realistic look. Then a
'  dynamic light is added to the scene to display moving shadows.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim RoomMesh As Integer
Dim MeshTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer


'  ////////////////////////////////////////////////////////////////////////////

'  -----------------------------------------------------------------------------
'  start the irrlicht interface
  'iUseOpenGL()
  iUseSoftware()
  iVSync( True )
iIrr3D( 800, 600, 32, False )

'  start the XEffect system, this must be called before any other XEffect
'  commands. we switch off VSM shadows but switch on soft shadowing
iXFXStart( False, True, False )

'  set the window caption
iAppTitle( "Example 99: XEffects Dynamic Shadows" )

'  load a mesh this acts as a blue print for the model
SceneNode = iLoadMeshNode( "./media/temple.obj", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/temple_lightmap.jpg" )

'  add the mesh to the scene as a new node, the node is an instance of the
'  mesh object supplied here
' SceneNode = biAddMeshToScene( RoomMesh )

'  scale the node up a little (this will not effect this shaders lighting)
iScaleNode( SceneNode, 14.0, 14.0, 14.0 )

'  add dynamic shadows to this node, it will both cast and receive shadows
iXFXAddShadowToNode( SceneNode, EFT_8PCF, ESM_BOTH )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pure black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

'  add a dynamic shadow casting light
'  1) the size of the shadow map texure this should always be a power of two.
'     512, 1024, 2048, etc ... bigger numbers = more quality = more memory
'  2) three numbers specify the X,Y,Z position of the light
'  3) three numbers specify the X,Y,Z target of the light. a dynamic light is
'     shaped like a spotlight so it needs a target to shine at.
'  4) four numbers specify the R,G,B,A intensity of the light
'  5) two numbers specify the near and far distance of the effect of the light
'  6) the angle of the spotlight 90 degrees in this case
iXFXAddShadowLight ( 512, 200,200,0, 0,0,0, 0.9,0.9,0.6,0.0, 1.0, 1200.0, 89.99 )

'  set the ambient lighting applied by the XEffects system
iXFXSetAmbientColor( 0,55,55,55)


'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
OurCamera = iCreateFPSCamera( 0, 100.0, 0.1, -1,0,0,0,0.0)
iPositionNode( OurCamera, 150,80,100 )
iCameraTarget( OurCamera, 0,0,0 )

'  hide the mouse
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
Dim moveCircle As Single = 0.0

While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  begin the scene
        iBeginScene()

         '  move the light about to show the dynamic lighting effect
        iXFXSetShadowLightPosition( 0, 200, (Cos( moveCircle ) + 1) * 75 + 50, (Sin( moveCircle ) + 1 ) * 75 + 50 )
        moveCircle = moveCircle + 0.01 ' 0.01

         '  draw the scene
        iDrawScene()
        
         '  end drawing the scene and render it
        iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
