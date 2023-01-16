'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 28 : Hillplane
'  This example creates a terrain from a hillplane object that is a generated
'  mesh grid with an irregular surface.
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
Dim TerrainTexture0 As Integer
Dim TerrainTexture1 As Integer
Dim Camera As Integer
Dim CameraNode As Integer
Dim Hillmesh As Integer
Dim HillNode As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 28: Hill Planes" )


'  add a hill plane mesh to the mesh pool and scene
HillMesh = iCreateHillPlaneMesh( "HillPlane", 16.0, 16.0, 64, 64, False, 12.0, 4, 3, 1, 1 )

HillNode = iAddMeshToScene( HillMesh )

'  we load two textures in to apply to the hillplane node
TerrainTexture0 = iLoadTexture( "./media/terrain-texture.jpg" )
TerrainTexture1 = iLoadTexture( "./media/detailmap3.jpg" )

'  the first texture is a color texture that is applied across the entire
'  surface of the map. this needs to be a fairly high resoloution as the map is
'  very large now
iNodeTexture( HillNode, TerrainTexture0, 0 )

'  the second texture is tiled many times across the map this adds fine detail
'  and structure to the first enlarged terain color
iNodeTexture( HillNode, TerrainTexture1, 1 )

'  finally we apply some material texuring effects to the node
'  the terrain is self illuminating
iNodeMaterialFlag( HillNode, IRR_EMF_LIGHTING, IRR_OFF )

'  the material type is detail type. this type applies the first texture across
'  the entire node and then scales and applies the second texture across the node
'  there are many different material types you can set, these can be found in the
'  .bi definition file, experiment with them
iNodeMaterialType ( HillNode, IRR_EMT_DETAIL_MAP )

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
