'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 10 : Terrain and Fog
'  This example creates a terrain from a bitmap heightfield and displays it in
'  a foggy scene
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

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 10: Terrain and Fog" )

'  here we create the terrain from a greyscale bitmap where bright pixels are
'  high points and black pixels are low points. the command generates the mesh
'  and automatically adds it as a node to the scene
Terrain = iLoadTerrain( "./media/iheight.jpg",0,0,0,0,0,0,1,1,1,255,255,255,255,2,5,ETPS_17 )

'  the node is too small to be a proper terrain so we get the node object of the
'  terrain and scale its size up 40 times along the X and Z axis and just 4 times
'  along the Y axis
TerrainNode = Terrain
iScaleNode( TerrainNode, 40.0, 4.4, 40.0 )

'  we load two textures in to apply to the terrain node
TerrainTexture0 = iLoadTexture( "./media/island.jpg" )

TerrainTexture1 = iLoadTexture( "./media/detailmap3.jpg" )

'  the first texture is a color texture that is applied across the entire
'  surface of the map. this needs to be a fairly high resoloution as the map is
'  very large now
iNodeTexture( TerrainNode, TerrainTexture0, 0 )

'  the second texture is tiled many times across the map this adds fine detail
'  and structure to the first enlarged terain color
iNodeTexture( TerrainNode, TerrainTexture1, 1 )

'  we set the scale of the detail map so its repeated 20 times across the map in
'  the x and y axis
iScaleTerrainTexture( Terrain, 1.0, 40.0 )

'  finally we apply some material texuring effects to the node
'  the terrain is self illuminating
iNodeMaterialFlag( TerrainNode, IRR_EMF_LIGHTING, False )
'  the material type is detail type. this type applies the first texture across
'  the entire node and then scales and applies the second texture across the node
'  there are many different material types you can set, these can be found in the
'  .bi definition file, experiment with them
iNodeMaterialType ( TerrainNode, IRR_EMT_DETAIL_MAP )

'  finally we switch on fog for this material so that this terrain will fade out
'  into a fog in the distance
iNodeMaterialFlag( TerrainNode, IRR_EMF_FOG_ENABLE, True )

'  now we need to add the fog to the scene. the first three parameters are the
'  fog color, we set this to the same color as our sky so the scene fogs out
'  nicely into nothing, the next parameter specifies whether you want the fog
'  to increase in a linear mannar or exponentially - exponential fog usually
'  looks more atmospheric while linear looks more like a dense sea fog, the next
'  two parameters specify the distance at which the fog starts and the distance
'  at which the fog reaches its maximum density and finally the fog density -
'  this is only used with exponential fog and determines how quickly the
'  exponential change takes place
iCameraFog ( 128,255,255, IRR_EXPONENTIAL_FOG, 0.0,4000.0, 0.5 )


'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )
iPositionNode( Camera, 3942.8, 1202.7, 5113.9 )
iRotateNode( Camera, 19, -185.5, 0 )

'  the clipping distance of a camera is a distance beyond which no triangles are
'  rendered, this speeds the scene up by not showing geometry that is in the
'  distance and too small to see however our terrain is so huge we need to
'  extend this distance out
iCameraRange( Camera, 12000, 1.0)

'  we also hide the mouse pointer to see the view better
iHideMouse()

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
