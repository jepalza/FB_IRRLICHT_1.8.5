'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 08: Shadows and Lights
'  This example loads a map and a model into the scene and then applies realtime
'  shadows to the model cast from lights in the scene that can be seen on the
'  surface of other objects.
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
Dim BSPMesh As Integer
Dim BSPNode As Integer
Dim OurCamera As Integer
Dim Light As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 08: Shadows and Lights" )

'  load the MD2 model from example 4 into the scene
SceneNode = iLoadAnimMesh( "./media/zumlin.md2", False )
MeshTexture = iLoadTexture( "./media/zumlin.pcx" )
iNodeTexture( SceneNode, MeshTexture, 0 )
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )
iPlayMD2Animation( SceneNode, IRR_EMAT_STAND )

'  load the bsp map from example 5 into the scene
iAddZipFile( "./media/map-20kdm2.pk3", IRR_IGNORE_CASE, IRR_IGNORE_PATHS, "" )
BSPMesh = iLoadOctreeMesh( "20kdm2.bsp" )
BSPNode = iAddOctreeMeshNode( BSPMesh )

'  move the map into position around the model
iPositionNode( BSPNode, -1370,-88,-1400)

'  add a camera into the scene
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 50, 0, 0 )

'  switching shadows on is very simple just call the command for the scene node
'  that you want to cast shadows
iNodeShadow( SceneNode )

'  the shadow colour is a global property for the whole scene (however you can
'  change it as you move into different areas of your scene) the first
'  parameter is the alpha blend for the shadow this shadow is half washed out
'  which gives the appearence of ambient light in the room illuminating the
'  shadowed surface, the second set of numbers defines the color of the shadow
'  which in this case is black
iShadowColor( 128, 0, 0, 0 )

'  finally we need to add a light into the scene to cast some shadows. when using
'  shadows you probably only want one or two lights as they can be time consuming
'  the first set of parameters for this light specify the position its created
'  at, the second set of parameters define the color - rather than 255 integer
'  levels the intensity of red/green/blue is defined from 0 to 1 and finally
'  you define the radius of effect of the light 
Light = iCreateLight( IRR_NO_PARENT, 100,100,-100, 0.9,0.3,0.3, 600.0 )

'  the second light is an ambient light and illuminates all surfaces in the scene
'  uniformly. this is usually a low value that is used to change the lighting
'  level across the entire scene
iAmbientLight( 0.1, 0.1, 0.1 )

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

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
