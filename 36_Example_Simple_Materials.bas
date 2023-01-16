'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 36 : Simple materials
'  This example sets simple material properties to alter surface lighting and
'  then dynamically alters the properties of those materials as the program runs
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim SphereNode As Integer
Dim NodeTexture As Integer
Dim Material As Integer
Dim Light As Integer
Dim Camera As Integer
Dim EmittedLevel As Integer = 0
Dim EmittedDirection As Integer = 1

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 36: Simple Materials" )

'  create some simple scene objects
SphereNode = iCreateSphere( 16, False )

'  add a simple point light
Light = iCreateLight( False, -100,100,100, 0.25,0.25,0.25, 600.0 )

'  set the ambient light level across the entire scene
iAmbientLight( 0.1,0.1,0.1 )

'  get the nodes material
Material = iGetMaterial( SphereNode, 0 )

'  set the surface property effected by the vertex color. as we want the material
'  to define the color of reflected ambient, diffuse and specular light we set
'  this to none. By default on a node it is ECM_DIFFUSE meaning that setting the
'  diffuse color has no effect because the diffuse color is taken from the color
'  of the verticies, something we do not want in this example.
iMaterialVertexColorAffects( Material, ECM_NONE )

'  make the sphere have a shiny red highlight, it will also reflect the diffuse
'  lighting making it appear yellow
iMaterialShininess( Material, 25.0 )
iMaterialSpecularColor( Material, 0,255,0,0 )

'  set the diffuse color of the object to green
iMaterialDiffuseColor ( material, 0,0,255,0 )

'  set the color of ambient light reflected by the object to blue
iMaterialAmbientColor ( Material, 0,0,0,255 )

'  add a camera to the scene to view the objects
Camera = iCreateCamera( SphereNode )
iPositionNode( Camera, -10,0,0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 0, 0, 0 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running

While iRun() And (Not iKeyHit( KEY_ESCAPE ))

	 '  begin the scene
	iBeginScene()

	 '  bring the emitted lighting from the object up and down
	iMaterialEmissiveColor ( Material, 0,EmittedLevel,EmittedLevel,EmittedLevel )
    
	EmittedLevel = EmittedLevel + EmittedDirection
	If EmittedLevel = 255 Then
		EmittedDirection = -1
	Else
		If EmittedLevel = 0 Then
			EmittedDirection = 1
		End If
	End If
	 '  draw the scene
	iDrawScene()
        
	 '  end drawing the scene and render it
	iEndScene()
        
Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
