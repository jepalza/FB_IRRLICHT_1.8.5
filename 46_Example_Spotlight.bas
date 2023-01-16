'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 46 : Spotlight
'  This example creates a simple scene and then animates a spotlight moving
'  across its surface
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MD2Mesh As Integer
Dim ObjectTexture As Integer
Dim SphereMesh As Integer
Dim SphereNode As Integer
Dim HillMesh As Integer
Dim HillNode As Integer
Dim OurCamera As Integer
Dim Light As Integer
Dim rotation As Single = 70

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 46: Spotlight" )

'  load texture resources for texturing the scene nodes
ObjectTexture = iLoadTexture( "./media/water.png" )

'  add the mesh to the scene as a new node, the node is an instance of the
'  mesh object supplied here
SphereNode = iCreateSphere( 32, False )

'  add a hill plane mesh to the mesh pool, the flat surface is created from a
'  flat hillplane so that there are a number of verticies in the object that
'  better reflect the lighting effect
HillMesh = iCreateHillPlaneMesh( "HillPlane", 5, 5, 32, 32, False, 12.0, 4, 3, 1, 1 )
HillNode = iAddMeshToScene( HillMesh )
iPositionNode( HillNode, 0, -20, 0 )

'  apply a material to the nodes to give them surface color
iNodeTexture( SphereNode, ObjectTexture, 0 )
iNodeTexture( HillNode, ObjectTexture, 0 )

'  add a simple point light
Light = iCreateLight( False, 30,200,0, 1.0,1.0,1.0, 600.0 )

'  convert the light into a spotlight and set the light cones attributes
iLightType( Light, ELT_SPOT )
iLightConeAngle( Light, 10, 20 )
iLightFalloff( Light, 100.0 )

'  add a camera into the scene
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 0,50,50 )

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 0, 0, 16 )
'  -----------------------------------------------------------------------------

While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene
    iBeginScene()

     '  swing the light node around slowly
    iRotateNode( Light, rotation, 0, 0 )
    rotation = rotation + 0.01
	If rotation > 110 Then rotation = 70

     '  draw the scene
    iDrawScene()
    
     '  draw the GUI
     ' IDrawGUI()

     '  end drawing the scene and render it
    iEndScene()
Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
