'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 108 : Lighting Bolt node
'  A special effects node that simulates a electrical discharge
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim OurCamera As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 108: Lighting Bolt Node" )

'  load a mesh this acts as a blue print for the model
Dim SceneNode As Integer = iLoadMeshNode( "./media/cylinderX.obj", False )

'  load texture resources for texturing the scene nodes
Dim Texture As Integer = iLoadTexture( "./media/water.png" )

'  create the a base for the effect and move, scale and rotate it into position
' SceneNode = IrrAddMeshToScene( Mesh )
iPositionNode( SceneNode, 0,47,0)
iRotateNode( SceneNode, 0,0,90 )
iScaleNode( SceneNode, 45,2,2 )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, Texture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False)
iNodeMaterialType ( SceneNode, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  add the lightning bolt node to the scene
SceneNode = iCreateBolt()

'  apply a material to the beam to give its surface color
Texture = iLoadTexture( "./media/beam.png" )
iNodeTexture( SceneNode, Texture, 0 )

'  set the bolt properties
iBoltProperties ( SceneNode, 0,90,0, 0,0,0, 50, 10, 5, 10, 4, True, 255, 255, 255, 255 )

'  add a camera into the scene
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 40, 50, 40 )
iCameraTarget( OurCamera, 0, 50, 0 )

iCameraCLSColor( 16, 24, 32 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  begin the scene, erasing the canvas with sky-blue before rendering
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
