'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 109 : Beam node
'  This example demonstrates the beam node
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MD2Mesh As Integer
Dim MeshTexture As Integer
Dim SceneNode As Integer
Dim OurCamera As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 109: Beam node" )

'  load texture resources for texturing the scene nodes
MeshTexture = iLoadTexture( "./media/beam.png" )

'  add a new beam node to the scene
SceneNode = iCreateBeam()

'  apply a material to the node to give its surface color
iNodeTexture( SceneNode, MeshTexture, 0 )

'  use transparency with this billboard type node
iNodeMaterialType ( SceneNode, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  add a camera into the scene, the first co-ordinates represents the 3D
'  location of our view point into the scene the second co-ordinates specify the
'  target point that the camera is looking at
OurCamera = iCreateCamera( False )
iPositionNode( OurCamera, 50, 0, 0 )

'  generate an initial random position
Dim x As Single = -400
Dim y As Single = Rnd(1)*40-20
Dim z As Single = Rnd(1)*40-20

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  begin the scene
        iBeginScene()

         '  set the beam position
        x = x + 2
        iPositionBeam( Scenenode, x, y, z,  x + 100, y, z )

         '  If the beam exceeds 600 restart it
        If x > 200 Then
            x = - 400
            y = Rnd(1)*40-20
            z = Rnd(1)*40-20

        	 '  set the beam size
   		Dim SIZE As Single = Rnd(1)*2+0.1
        	iBeamSize( Scenenode, size )

        EndIf

         '  draw the scene
        iDrawScene()
        
         '  end drawing the scene and render it
        iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
