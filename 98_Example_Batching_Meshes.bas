'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 98 : Batching Meshes
'  This example demonstrates how avoiding large numbers of scene nodes by
'  copying the nodes mesh into a single mesh multiple times can have a
'  significant improvement of the speed of the program
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  COMMENT this out to add all of the nodes seperately 
Const BATCHING = True
'  CHANGE this to control how many objects are added
Const ROWS_AND_COLUMNS = 50


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MiniMesh As Integer
Dim MeshTextureA As Integer
Dim MeshTextureB As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer
Dim framerate As Integer
Dim fpsString As String


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  add a static text field for the frame rate
framerate = iStaticText( "Calculating ...", 4,492, 508,508, IRR_GUI_BORDER, IRR_GUI_NO_WRAP, False )

'  set the window caption
iAppTitle( "Example 98: Batching Meshes" )

'  load a mesh this acts as a blue print for the model
MiniMesh = iLoadMesh( "./media/cylinderY.obj" )

iScaleMesh( MiniMesh, 4.0, 0, False, False )

'  for a fair test make sure that the cylinder object is hardware accellerated
iHWAcceleratedMesh( MiniMesh, False )

'  load texture resources for texturing the scene nodes
MeshTextureA = iLoadTexture( "./media/Cross.bmp" )
MeshTextureB = iLoadTexture( "./media/Diagonal.bmp" )

Dim As Integer i,j
If BATCHING Then
'  create a batching mesh that will be a collection of other meshes
Dim meshBatch As Integer = iCreateBatchingMesh()

'  add a whole mass of meshes to the batch mesh
For i = -ROWS_AND_COLUMNS/2 To ROWS_AND_COLUMNS/2
    For j = -ROWS_AND_COLUMNS/2 To ROWS_AND_COLUMNS/2

         '  as we are going to add this mesh as a single node if we want to use
         '  different textures with different meshes we need to apply them to the
         '  mesh before we add the mesh to the batch
        If ( i + (j Mod 2)) Mod 2 = 0 Then
             '  set the texture of the mesh before you add it so that the
             '  seperate meshes have their own colors
             '  This one will be BLUE
            iMeshTexture( miniMesh, MeshTextureA, 0, False )
        Else
             '  set the texture of the mesh before you add it so that the
             '  seperate meshes have their own colors
             '  This one will be RED
            iMeshTexture( miniMesh, MeshTextureB, 0, False )
        End if
        
         '  Add this mesh to the batch at its own unique position
        iAddToBatchingMesh ( meshBatch, MiniMesh, i*10.0, j*10.0, 0, 0, 0, 0, 1.0, 1.0, 1.0 )
    Next
Next

'  finish adding meshes to the batch mesh and create an animated mesh from it
MiniMesh = iFinalizeBatchingMesh ( meshBatch )

'  get more speed by making the mesh hardware accellerated
iHWAcceleratedMesh( MiniMesh, 0 )

'  add the mesh to the scene as a new node, the node is an instance of the
'  mesh object supplied here
SceneNode = iAddMeshToScene( MiniMesh )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

Else

'  Add rows of seperate nodes to demonstrate the speed difference
For i = -ROWS_AND_COLUMNS/2 To ROWS_AND_COLUMNS/2
    For j = -ROWS_AND_COLUMNS/2 to ROWS_AND_COLUMNS/2
        SceneNode = iAddMeshToScene( MiniMesh )
        iPositionNode( SceneNode, i*10.0, j*10.0, 0.0 )
        if ( i + (j mod 2)) mod 2 = 0 Then
            iNodeTexture( SceneNode, MeshTextureA, 0 )
        Else
            iNodeTexture( SceneNode, MeshTextureB, 0 )
        End if
        iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )
    Next
Next
EndIf

'  add a camera into the scene
OurCamera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )
iPositionNode( OurCamera, 0, 0, ROWS_AND_COLUMNS * 10 )
iHideMouse()

iCameraCLSColor( 240, 255, 255 )
'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene
    
     '  format and display the framerate
    fpsString = "FPS: " + Str(iGetFPS()) + "    Objects: " + Str( ROWS_AND_COLUMNS*ROWS_AND_COLUMNS ) + "    Polys: " + Str(iTrisDrawn()) + "    Per Object: " + Str(iTrisDrawn()/(ROWS_AND_COLUMNS*ROWS_AND_COLUMNS))
    iGUISetText( framerate, fpsString )

     '  draw the GUI
    iDrawGUI()

     '  end drawing the scene and render it
    iEndScene()
Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
