'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 05: BSP Map
'  This example loads a BSP map from a pk3 archive and creates a first person
'  perspective camera so you can move around and view the map with the mouse and
'  the arrow keys
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

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
 iUseOpenGL()
 'iUseSoftware()
iIrr3D( 800, 600, 32, False )


'  send the window caption
iAppTitle( "Example 05: BSP Map" )

'  first we add the pk3 archive to our filing system. once we have done this
'  we can open any of the files in the archive as if they were in the current
'  working directory
iAddZipFile( "./media/map-20kdm2.pk3", IRR_IGNORE_CASE, IRR_IGNORE_PATHS, "" )

'  load the BSP map from the archive as a mesh object. any polygons in the mesh
'  that do not have textures will be removed from the scene!
BSPMesh = iLoadOctreeMesh( "20kdm2.bsp" )

'  add the map to the scene as a node. when adding the mesh this call uses a 
'  mechanism called an octtree that if very efficient at rendering large amounts
'  of complext geometry most of which cant be seen, using this call for maps
'  will greatly improve your framerates
BSPNode = iAddOctreeMeshNode( BSPMesh )

'  add a first person perspective camera into the scene that is controlled with
'  the mouse and the cursor keys. if however you capture events when starting
'  irrlicht this will become a normal camera that can only be moved by code
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  reposition and rotate the camera to look at a nice part of the map
iPositionNode( Camera, 1750, 149, 1369 )
iRotateNode( Camera, 4, -461.63, 0 )

'  hide the mouse pointer
iHideMouse()

'  erase the canvas with sky-blue Before rendering
iCameraCLSColor( 128, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and display it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
