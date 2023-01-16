'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 78: 2D Overlaid Hud
'  This example loads a BSP map from a pk3 archive and creates a first person
'  perspective camera so you can move around and view the map it also overlays
'  a 2D hud onto the screen to display information
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
Dim CameraNode As Integer
Dim HUDBulletTexture As Integer
Dim HUDCharacterTexture As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 78: 2D Overlaid HUD" )

'  first we add the pk3 archive to our filing system. once we have done this
'  we can open any of the files in the archive as if they were in the current
'  working directory
iAddZipFile( "./media/map-20kdm2.pk3", IRR_IGNORE_CASE, IRR_IGNORE_PATHS, "" )

'  load the BSP map from the archive as a mesh object. any polygons in the mesh
'  that do not have textures will be removed from the scene!
BSPMesh = iLoadOctreeMesh( "20kdm2.bsp" )


'  load hud components
HUDBulletTexture = iLoadTexture( "./media/HUDBullet.tga" )
HUDCharacterTexture = iLoadTexture( "./media/HUDCharacter.tga" )

'  add the map to the scene as a node. when adding the mesh this call uses a 
'  mechanism called an octtree that if very efficient at rendering large amounts
'  of complext geometry most of which cant be seen, using this call for maps
'  will greatly improve your framerates
BSPNode = iAddOctreeMeshNode( BSPMesh )

'  add a first person perspective camera into the scene that is controlled with
'  the mouse and the cursor keys. if however you capture events when starting
'  irrlicht this will become a normal camera that can only be moved by code
Camera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )

'  when we add a camera we are returned a camera object however we can perform
'  node operations on many different object types that are entities within the
'  scene however first we need to convert the camera type into a node type
CameraNode = Camera

'  reposition and rotate the camera to look at a nice part of the map
iPositionNode( CameraNode, 1750, 149, 1369 )
iRotateNode( CameraNode, 4, -461.63, 0 )

'  hide the mouse pointer
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

Dim i As integer
'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()
 
     '  draw some bullets
    For i = 0 To 3
        iDrawImageElement( HUDBulletTexture,754, 4 + i * 16, 0,0,32,16, True )
    Next

     '  draw a character
    iDrawImageElement( HUDCharacterTexture, 4, 4, 0,0,64,64, True )

     '  end drawing the scene and display it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
