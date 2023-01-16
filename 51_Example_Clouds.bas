'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 51 : Clouds
'  This example demonstrates the billboard cloud objects that are particularly
'  useful for simulating aircraft flying through cloud cover and also for
'  creating a light cloud embelishment for a skydome
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
Dim CloudTexture As Integer
Dim CloudNode As Integer
Dim X As Single
Dim Y As Single
Dim Z As Single
Dim TerrainHeight As Single


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 51: Billboard Clouds by G Davidson" )

'  load the cloud image in as a video texture
CloudTexture = iLoadTexture( "./media/cloud4.png" )

'  add the clouds to the scene
'  the first parameter is the level of detail, higher values add more structure
'  to the cloud when it is closer to the camera
'  the second parameter sets the number of child clouds created higher values
'  create more structure
'  the third parameter defines how many clouds are created
CloudNode = iCreateClouds( CloudTexture, 3, 1, 500 )

'  switch the fog on the clouds to prevent the clouds popping up in the distance
iNodeMaterialFlag( CloudNode, IRR_EMF_FOG_ENABLE, True )

'  raise the clouds into the sky
iPositionNode( CloudNode, 0,2700,0 )

'  slowly rotate the clouds to simulate drift across the sky
iRotationAnimator( CloudNode, 0, 0.01, 0 )

'  we add a terrain to the scene for demonstration purposes, for a detailed
'  explaination of the process please refer to example 10
Terrain = iLoadTerrain( "./media/iheight.jpg",0,0,0,0,0,0,1,1,1,255,255,255,255,0,5,ETPS_17 )
TerrainNode = Terrain
iScaleNode( TerrainNode, 40.0, 4.4, 40.0 )
TerrainTexture0 = iLoadTexture( "./media/island.jpg" )
TerrainTexture1 = iLoadTexture( "./media/detailmap3.jpg" )
iNodeTexture( TerrainNode, TerrainTexture0, 0 )
iNodeTexture( TerrainNode, TerrainTexture1, 1 )
iScaleTerrainTexture( Terrain, 1.0, 40.0 )
iNodeMaterialFlag( TerrainNode, IRR_EMF_LIGHTING, False )
iNodeMaterialType ( TerrainNode, IRR_EMT_DETAIL_MAP )
iNodeMaterialFlag( TerrainNode, IRR_EMF_FOG_ENABLE, True )

'  add a fog to the scene to gently fade the clouds out in the distance
iCameraFog ( 128,128,255, IRR_EXPONENTIAL_FOG, 0.0,4000.0, 0.5 )

'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 3942.8, 1102.7, 5113.9 )
iRotateNode( CameraNode, 19, -185.5, 0 )

'  the clipping distance of a camera is a distance beyond which no triangles are
'  rendered, this speeds the scene up by not showing geometry that is in the
'  distance and too small to see however our terrain is so huge we need to
'  extend this distance out
iCameraRange( Camera, 12000, 1.0 )

iCreateCube( 8, False )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 128, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

	X = iNodeX( CameraNode, False )
	Z = iNodeZ( CameraNode, False )

    TerrainHeight = iTerrainHeight( TerrainNode, X, Z )
    iPositionNode( CameraNode, X, TerrainHeight + 50, Z )

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and render it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End

