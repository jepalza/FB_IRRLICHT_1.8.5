'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 75: Push Particle Explosion
'  This example demonstrates the use of the push particle affector to create a
'  flash explosion like effect.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim ParticleTexture As Integer
Dim SmokeParticles As Integer
Dim SmokeEmitter As Integer
Dim ParticlesNode As Integer
Dim TestNode As Integer
Dim Camera As Integer
Dim FadeOut As Integer
Dim fade As Single

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 75: Push Particle Explosion" )

'  this adds a small test node to the scene, a test node is a simple cube, that
'  you can move and texture like any other object however there is another
'  reason for adding this node. the particle system needs another node rendered
'  onto the display to allow it to display material effects. this may be an issue
'  with the wrapper that needs investigation
TestNode = iCreateCube( 8, False )

'  set up a particle system that generates a stream of smoke please see example
'  Seven for detailed information
SmokeParticles = iCreateParticleSystem( False,0,-1,0,0,0,0,0,0,1,1,1 )

'  finally we add this particle emitting object to the particle system along
'  with a series of affectors
SmokeEmitter = iCreateParticleEmitter( SmokeParticles, -7, 0, -7, 7, 7, 7, 0, 0, 0, 2000, 2000, 255, 255, 255, 255, 255, 255, 300, 300, 15.0, 15.0, 15.0, 15.0, 15 )

iFadeOutAffector( SmokeParticles, 2000, 16,8,0 )

'  push the particles upward for 100 units above the affector
iPushAffector ( SmokeParticles, 0, 0, 0, 300, 300, 300, 50, 0.0, 0.0, True )

'  load a grey smoke like image for the particle
ParticleTexture = iLoadTexture( "./media/ParticleGrey.bmp" )

Dim As Integer SmokeParticlesNode = SmokeParticles

'  apply the texture to the particles system, this texture will now be drawn
'  across each particles surface
iNodeTexture( SmokeParticlesNode, ParticleTexture, 0 )

'  out particle system is not affected by lighting so we make it self
'  illuminating
iNodeMaterialFlag( SmokeParticlesNode, IRR_EMF_LIGHTING, False )

'  as the particle texture has black borders, each overlapping particle would
'  draw this blackness ontop of one another as a sharp egde they would look like
'  a lot of solid squares instead of the transparent gas effect we are trying
'  to created. so here we change the material type of the node - instead of
'  drawing the node solidly onto the screen it is added onto the colour
'  underneath itself so black doesnt change the color and white would build up
'  top of the existing color until it completly saturates the pixel
iNodeMaterialType ( SmokeParticlesNode, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  add a fixed position camera to the scene so we can view the particle system.
'  the first three parameters are the cameras location, the second three
'  parameters are where the camera is looking at
Camera = iCreateCamera( False )
iPositionNode( Camera, 100, 40, 0 )
iCameraTarget( Camera, 0, 40, 0 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
Dim StartTime As Integer = iTime()
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  clear the canvas to black to show the particles up better
    iBeginScene()

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and display it
    iEndScene()

     '  Only create particles for the first second
    If iTime() > StartTime + 500 Then 
        iEmitterMinParticlesPerSecond( SmokeEmitter, 0 )
        iEmitterMaxParticlesPerSecond( SmokeEmitter, 0 )
    End If 

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
