'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 65 : Spherical Terrain
'  This example creates a spherical terrain by attaching six terrain objects
'  together in a cube and then applying a spherical distortion to the terrains.
'  the six textures applied to the terrain sphere need to be carefully
'  constructed so that they are properly applied.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

' add planet sphere
Declare Sub AddPlanet( px As Single,py As Single,pz As Single, rx As Single,ry As Single,rz As Single, col As Integer )

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
Dim Shared TerrainTexture0 As Integer
Dim Shared TerrainTexture1 As Integer

'  irrlicht objects
Dim Terrain As Integer
Dim TerrainNode As Integer
Dim Camera As Integer
Dim CameraNode As Integer
Dim BitmapFont As Integer
Dim metrics As String
Dim Light As Integer
Dim SkyBox As Integer
Dim Billboard As Integer
Dim BillboardTexture As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 1024, 768, 32, False )

'  send the window caption
iAppTitle( "Example 65: Spherical Terrain" )

BitmapFont = iLoadFont ( "./media/bitmapfont.bmp" )
TerrainTexture0 = iLoadTexture( "./media/terrain-texture.jpg" )
TerrainTexture1 = iLoadTexture( "./media/detailmap-dim.jpg" )

'  add a spherical terrain to the scene
AddPlanet( 0,0,0, 0,0,0, 255 )

'  add a simple skybox to the scene to represent space
Dim As Integer SB1Tex = iLoadTexture("./media/stars.jpg")


SkyBox = iCreateSkybox( SB1Tex,SB1Tex,SB1Tex,SB1Tex,SB1Tex,SB1Tex)

iCameraFog ( 255,128,0, IRR_EXPONENTIAL_FOG, 0.0,500.0, 0.5 )

Light = iCreateLight( False, 6400,16000,0, 1,1,1, 192200.0 )
iAmbientLight( 0.1, 0.1, 0.1 )


'  we add a first person perspective camera to the scene so you can look about
'  and move it into the center of the map
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)
CameraNode = Camera
iPositionNode( CameraNode, 0, 2000, 0 )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/sun.tga" )

'  add the billboard to the scene, the first two parameters are the size of the
'  billboard in this instance they match the pixel size of the bitmap to give
'  the correct aspect ratio. the last three parameters are the position of the
'  billboard object
Billboard = iCreateBillBoard( 600.0,600.0,  3000.0, 1500.0, 0.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeTexture( Billboard, BillboardTexture, 0 )

'  rather than have the billboard lit by light sources in the scene we can
'  switch off lighting effects on the model and have it render as if it were
'  self illuminating
iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, False )
iNodeMaterialType( Billboard, IRR_EMT_TRANSPARENT_ALPHA_CHANNEL )
iMaterialTypeParam( iGetMaterial( Billboard, 0 ), 0.0001 )

'  the clipping distance of a camera is a distance beyond which no triangles are
'  rendered, this speeds the scene up by not showing geometry that is in the
'  distance and too small to see however our terrain is so huge we need to
'  extend this distance out
iCameraRange( Camera, 500000, 1.0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 0, 0, 0 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()

    metrics = "Example 65: Spherical Terrain ("+Str(iGetFPS())+") fps ("+Str(iTrisDrawn())+" Polygons)"
    iAppTitle( metrics )

     ' metrics = "PRIMS: "+ Str(iTrisDrawn())
     ' iText ( BitmapFont, metrics, 4, 4, 250, 24 )

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End


Sub AddPlanet( px As Single,py As Single,pz As Single, rx As Single,ry As Single,rz As Single, col As Integer )

	'  add the spherical terrain. this is supplied with six terrain highmaps one for
	'  each of the faces on the cube
	Dim As Integer Terrain = iCreateSphericalTerrain("./media/simplesphere.bmp", "./media/simplesphere.bmp", "./media/simplesphere.bmp", "./media/simplesphere.bmp", "./media/simplesphere.bmp", "./media/simplesphere.bmp", px,py,pz, rx,ry,rz, 6.4,6.4,6.4, 255, 255, 255, 255,  -30, 0, 4, ETPS_17 )
   Dim As Integer TerrainNode = Terrain
   iNodeTexture( TerrainNode, TerrainTexture0, 0 )
   iNodeTexture( TerrainNode, TerrainTexture1, 1 )
   iScaleSphericalTexture( Terrain, 1.0, 60.0 )
   iNodeMaterialType ( TerrainNode, IRR_EMT_DETAIL_MAP )

End Sub
