'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 30 : Animated Water Effect
'  This example creates an animated water effect that is applied to a flat
'  hillplane object. The effect alters the surface of the mesh in a manner that
'  simulates waves on water
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Terrain As Integer
Dim TerrainNode As Integer
Dim TerrainTexture As Integer
Dim Camera As Integer
Dim CameraNode As Integer
Dim WaterMesh As Integer
Dim WaterNode As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 30: Animated Water Effect" )


'  add a hill plane mesh to the mesh pool
WaterMesh = iCreateHillPlaneMesh( "HillPlane", 16.0, 16.0, 64, 64,  0,  0.0, 4, 3, 8, 8 )

'  add a scene node for rendering an animated water surface mesh
WaterNode = iCreateWater( WaterMesh,2.0,300.0,10.0,0,-1,0,0,0,0,0,0,1.0,1.0,1.0)

'  we load two textures in to apply to the terrain node
TerrainTexture = iLoadTexture( "./media/water.png" )

'  the first texture is a color texture that is applied across the entire
'  surface of the map. this needs to be a fairly high resoloution as the map is
'  very large now
iNodeTexture( WaterNode, TerrainTexture, 0 )

'  finally we apply some material texuring effects to the node
'  the water is self illuminating
iNodeMaterialFlag( WaterNode, IRR_EMF_LIGHTING, False )

'  the sphere map material type gives a shiny effect appropriate for a
'  water surface
iNodeMaterialType ( WaterNode, IRR_EMT_SPHERE_MAP )

'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 0, 25, 0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue Before rendering
iCameraCLSColor( 140, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running

While iRun() And (Not iKeyHit(KEY_ESCAPE))

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
