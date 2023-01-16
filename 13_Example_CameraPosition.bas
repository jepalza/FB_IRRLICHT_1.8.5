'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 13: Camera Position
'  This example creates a map for you to move around and displays the current
'  position of the camera and its rotation on the screen
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim BSPMesh As Integer
Dim BSPNode As Integer
Dim Camera As Integer
Dim BitmapFont As Integer
Dim X As Single
Dim Y As Single
Dim Z As Single
Dim metrics As String

'  -----------------------------------------------------------------------------
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 13: Camera Position and Rotation" )

'  create a frist person perspective camera that can be controlled with mouse
'  and cursor keys
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  reposition and rotate the camera to look at a nice part of the map
iPositionNode( Camera, 1750, 149, 1369 )
iRotateNode( Camera, 4, -461.63, 0 )

'  load a Quake 3 BSP Map from a zip archive
iAddZipFile( "./media/map-20kdm2.pk3", IRR_IGNORE_CASE, IRR_IGNORE_PATHS, "" )
BSPMesh = iLoadOctreeMesh( "20kdm2.bsp" )
BSPNode = iAddOctreeMeshNode( BSPMesh )

'  load the bitmap font as a texture
BitmapFont = iLoadFont ( "./media/bitmapfont.bmp" )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 140, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()

     '  get the position of the camera into the three supplied variables
Dim 	px As Single = iNodeX( Camera, False )
Dim 	py As Single = iNodeY( Camera, False )
Dim 	pz As Single = iNodeZ( Camera, False )
	
     '  create a wide string with a list of the positions in
    metrics = "POSITION "+ Str(px) + " " + Str(py) + " " + Str(pz)
    
     '  draw this position information to the screen
    iText ( BitmapFont, metrics, 4, 4, 250, 24 )

     '  get the rotation of the camera into the three supplied variables
     ' IrrGetNodeRotation( CameraNode, X, Y, Z )
Dim 	rx As Integer = iNodePitch( Camera, False )
Dim 	ry As Integer = iNodeYaw( Camera, False )
Dim 	rz As Integer = iNodeRoll( Camera, False )
	    
     '  create a wide string with a list of the rotations in
    metrics = "ROTATION "+ Str(rx) + " " + Str(ry) + " " + Str(rz)
    
     '  draw this position information to the screen
    iText ( BitmapFont, metrics, 4, 32, 250, 52 )

     '  end drawing the scene and display it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
