'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 94 : Bump Mapping
'  This example loads in a Mesh Model and then then textures it using a bump
'  mapping technique called Normal Mapping. To see this effect your graphics
'  card will need to support pixel and vertex shaders version 1.1
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim ModelMesh As Integer
Dim DiffuseTexture As Integer
Dim BumpTexture As Integer
Dim SceneNodeNormal As Integer
Dim SceneNodeParallax As Integer
Dim OurCamera As Integer
Dim Light As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 1024, 768, 32, False )

'  set the window caption
iAppTitle( "Example 94: Bump Mapping" )

'  load a mesh this acts as a blue print for the model
ModelMesh = iLoadMesh( "./media/sphere.obj" )

'  the mesh is quite small so scale it up without effecting lighting
iScaleMesh( ModelMesh, 12.5, 0, 0, 0 )

'  load texture resources for texturing the scene node
DiffuseTexture = iLoadTexture( "./media/detailmap-dim.jpg" )
BumpTexture = iLoadTexture( "./media/earthbump.bmp" )

'  convert the grey scale image into a normal mapping texture. if you wish you
'  can create your own normal mapping texture but it is often simpler to create
'  a simple greyscale image as a bump map that defines the height of the surface
iNormalMapTexture( BumpTexture, 9.0 )

'  add the mesh to the scene twice to display two types of bump mapping effects
'  the mesh is added with a special command that creates a model with lighting
'  information embedded into it this is required for bump mapping
SceneNodeNormal = iStaticMeshForNormalMapping( ModelMesh )
iPositionNode( SceneNodeNormal, 0, 0, -15 )
SceneNodeParallax = iStaticMeshForNormalMapping( ModelMesh )
iPositionNode( SceneNodeParallax, 0, 0, 15 )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNodeNormal, DiffuseTexture, 0 )
iNodeTexture( SceneNodeNormal, BumpTexture, 1 )
iNodeTexture( SceneNodeParallax, DiffuseTexture, 0 )
iNodeTexture( SceneNodeParallax, BumpTexture, 1 )

'  Bump mapping is pointless unless lighting in enabled. we set the materials on
'  one of the nodes to Normal Mapping and on the other to Parallax mapping.
'  parallax mapping gives a richer deeping bump mapping effect but does require
'  a more modern graphics card
iNodeMaterialType ( SceneNodeNormal, IRR_EMT_NORMAL_MAP_SOLID )
iNodeMaterialType ( SceneNodeParallax, IRR_EMT_PARALLAX_MAP_SOLID )
iNodeMaterialFlag( SceneNodeNormal, IRR_EMF_LIGHTING, True )
iNodeMaterialFlag( SceneNodeParallax, IRR_EMF_LIGHTING, True )

'  add a camera into the scene
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 40, 0, 0 )

'  finally we need to add a light into the scene. bump mapping requires a
'  dynamic light to create the bump mapping effect. additionally the lights need
'  to be animated to show the changing light on the surface.
Light = iCreateLight( False, 100,100,-100, 0.9,0.3,0.3, 600.0 )
iFlyCircleAnimator( Light, 0,0,0, 100, 0.001 )

'  hide the mouse pointer away
iHideMouse()

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
