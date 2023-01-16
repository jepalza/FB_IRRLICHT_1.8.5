'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 100: XEffects Water
'  This example demonstrates the water shader supplied with the XEffects system
'  by Blindside. The effect occurs on the plane at Y = 0.0 and an effect is
'  generated both above and below the water. The animated effect is created by
'  changing the bitmap used to define the surface normal. While this set of
'  images are free to use, you will likely want to source a higher quality set
'  to improve the effect.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
' Include "vbcompat.bi"
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  SPECIFIES the number of frames in the water animation
Const WATER_FRAMES = 18
'  SPECIFIES that a new water frame will be used every two frames
Const NEW_IMAGE_EVERY = 2

'  irrlicht objects
Dim WaterTexture(WATER_FRAMES) As Integer

Dim MeshTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer
Dim filename As String


'  ////////////////////////////////////////////////////////////////////////////

'  start the irrlicht interface
iVSync( True )
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 100: XEffects Water" )

'  add a camera into the scene, position and target it
OurCamera = iCreateFPSCamera( 0, 100.0, 0.1, -1,0,0,0,0.0)
iPositionNode( OurCamera, 150,80,100 )
iCameraTarget( OurCamera, 0,0,0 )

'  start the XEffects system
iXFXStart( False, False, True )

'  enable the depth render pass, this is required for the water shader
iXFXEnableDepthPass( True )

Dim i As Integer
Dim As String fill
'  load a series of dump map images that define the bumpyness of the surface of
'  the water. these are then turned into normal maps for the shader to use
For i = 1 To WATER_FRAMES 
 	If i > 9 Then fill= "00" Else fill = "000"
    filename = "./media/water/water_" + fill + Trim(Str(i)) + ".png"
    WaterTexture(i) = iLoadTexture( filename )
    iNormalMapTexture( WaterTexture(i), 6.0 )
Next

'  load the shader associated with water rendering
iXFXAddPostProcessingFromFile( "./media/shaders/ScreenWater.hlsl",0 )

'  load a mesh and add it to the scene as a new node
SceneNode = iLoadMeshNode( "./media/temple.obj", False )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/temple_lightmap.jpg" )

'  scale the node up a little (this will not effect this shaders lighting)
iScaleNode( SceneNode, 14.0, 14.0, 14.0 )

'  Add the room to the depth pass test
iXFXAddNodeToDepthPass( SceneNode )

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  switch off lighting effects on this model, as there are no lights in this
'  scene the model would otherwise render pule black
iNodeMaterialFlag( SceneNode, IRR_EMF_LIGHTING, False )

'  XEffects does not use the background color defeined in bCameraCLSColor to
'  display as empty space, instead it uses the color defined here.
iXFXSetClearColor( 255,128,255,255)

'  hide the mouse from the display
iHideMouse()

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
i = NEW_IMAGE_EVERY
Dim direction As Integer = 1

While iRun() And (Not iKeyHit(KEY_ESCAPE))

         '  begin the scene
        iBeginScene()

         '  set the image used as the surface texture for this water frame
        iXFXSetPostProcessingUserTexture( WaterTexture(i/NEW_IMAGE_EVERY))
        
         '  keep on counting up images and reset back the begining if needed
        i = i + direction
        If i = (WATER_FRAMES + 1) * NEW_IMAGE_EVERY Then i = NEW_IMAGE_EVERY 

         '  draw the scene
        iDrawScene()
        
         '  end drawing the scene and render it
        iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
