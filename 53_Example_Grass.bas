'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 53 : Grass
'  An example of a grass object that is layered over a terrain to create extra
'  detail to a terrain increasing the realism
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
Dim terrainHeight As Integer
Dim terrainColor As Integer
Dim grassMap As Integer
Dim grassTexture As Integer
Dim grassNode As Integer
Dim x As Single
Dim y As Single
Dim z As Single


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D( 1024, 768, 32, False )

'  send the window caption
iAppTitle( "Example 53: Grass by G Davidson" )

'  allow transparency to write to the z buffer, this is often nessecary to make
'  many transparent objects appear in the correct order especially transparent
'  objects is opaque elements like grass and leaves, the only consideration is
'  that there will be an impact on performance
iTransparentZWrite( False )

'  here we create the terrain from a greyscale bitmap where bright pixels are
'  high points and black pixels are low points. the command generates the mesh
'  and automatically adds it as a node to the scene
Terrain = iLoadTerrain( "./media/iheight.jpg",0,0,0,0,0,0,1,1,1,255,255,255,255,0,5,ETPS_17 )

'  the node is too small to be a proper terrain so we get the node object of the
'  terrain and scale its size up 40 times along the X and Z axis and just 4 times
'  along the Y axis
TerrainNode = Terrain
iScaleNode( TerrainNode, 40.0, 2.4, 40.0 )

'  we load two textures in to apply to the terrain node
TerrainTexture0 = iLoadTexture( "./media/island.jpg" )
TerrainTexture1 = iLoadTexture( "./media/detailmap3.jpg" )

'  set up the terrain node with textures lighting
iNodeTexture( TerrainNode, TerrainTexture0, 0 )
iNodeTexture( TerrainNode, TerrainTexture1, 1 )
iScaleTerrainTexture( Terrain, 1.0, 60.0 )
iNodeMaterialFlag( TerrainNode, IRR_EMF_LIGHTING, False )
iNodeMaterialType ( TerrainNode, IRR_EMT_DETAIL_MAP )
iNodeMaterialFlag( TerrainNode, IRR_EMF_FOG_ENABLE, True )

'  load the textures and images for that node
TerrainHeight = iLoadImage( "./media/iheight.jpg" )
terrainColor = iLoadImage( "./media/island.jpg" )
grassMap = iLoadImage( "./media/island.jpg" )
grassTexture = iLoadTexture( "./media/grass.png" )

'  we add the grass in as 100 seperate patches, these could even be grouped
'  under a set of zone managers to make them more efficient
For x = 0 To 3
    For y = 0 To 3
         '  here we add the grass object, it has the following parameters: -
         '  a terrain onto which the grass layered,
         '  an x and y tile coordinate for the patch (multiplied by the patch size)
         '  a size for the patch
         '  the distance in patches upto which all blades of grass are drawn
         '  whether pairs of grass are aligned in a cross IRR_ON to enable
         '  a scale for the grass height
         '  the height map associated with the terrain used for setting grass height
         '  the texture map associated with the terrain used for coloring the grass
         '  a grass map defining the types of grass placed onto the terrain
         '  a texture map containing the images of the grass
        grassNode = iCreateGrass ( Terrain, x, y, 1100*3, 2.0, False, 0.5, 250, 0, 0, TerrainHeight, terrainColor, grassMap, grassTexture )
                                
         '  here we set how much grass is visible firstly the number of grass
         '  particles that can be seen and secondly the distance upto which they
         '  are drawn
        iGrassDensity ( grassNode, 600, 4000 )
        
         '  here we set the wind effect on the grass, first parameter sets the
         '  strength of the wind and the second the resoloution
        iGrassWind ( grassNode, 3.0, 1.0 )
        
        iNodeMaterialFlag( grassNode, IRR_EMF_LIGHTING, False )
        iNodeMaterialFlag( grassNode, IRR_EMF_FOG_ENABLE, True )
    Next
Next
        
'  now we need to add the fog to the scene
iCameraFog ( 128, 255, 255, IRR_EXPONENTIAL_FOG, 0.0,4000.0, 0.5 )


'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 3942.0, 650.0, 5113.0 )
iRotateNode( CameraNode, 19, -185.5, 0 )

'  the clipping distance of a camera is a distance beyond which no triangles are
'  rendered
iCameraRange( Camera, 12000, 1.0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

	x = iNodeX( CameraNode, False )
	z = iNodeZ( CameraNode, False )

    y = iTerrainHeight( Terrain, x, z )
    iPositionNode( CameraNode, x, y+160, z )

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and render it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
