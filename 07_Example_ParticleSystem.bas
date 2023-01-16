'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 07: Particle Effect
'  This example creates a particle system to demonstrate particle system effects
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
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 07: Particle Systems" )

'  this adds a small test node to the scene, a test node is a simple cube, that
'  you can move and texture like any other object however there is another
'  reason for adding this node. the particle system needs another node rendered
'  onto the display to allow it to display material effects. this may be an issue
'  with the wrapper that needs investigation
TestNode = iCreateCube( 8, False )


'  add a particle system to the irrlicht scene manager, a default emitter is not
'  created as we will define our own. the particle system is blank at the moment
' SmokeParticles.IRR_PARTICLE_EMITTER = New IRR_PARTICLE_EMITTER
SmokeParticles = iCreateParticleSystem( IRR_NO_EMITTER,0,-1,0,0,0,0,0,0,1,1,1 )

'  here we define the particle emitter, a particle emitter is a mechanism that
'  creates the particles over time and destroys them when their lifetime runs
'  out. The parameters include: a box that defines the volume in which particles
'  are created - the larger the box the more diffuse the particle cloud, a
'  direction that determines where the particles drift off too, a range that
'  defines hoe many particles will be generated each second, a colour range that
'  determines a random tint that is applied to the particles, a range that
'  determines the lifespan of the particles - the large the values the longer
'  and larger (and slower) your particle cloud will be and finally an angle that 
'  defines a cone around your direction that is the maximum deviation from the
'  direction the particles can take - values here make your particles billow
'  outward

'  finally we add this particle emitting object to the particle system
SmokeEmitter = iCreateParticleEmitter( SmokeParticles, -7, 0, -7, 7, 1, 7, 0, 0.04, 0, 80, 100, 255, 255, 255, 255, 255, 255, 800, 2000, 15.0, 15.0, 15.0, 15.0, 15 )

'  an affector is a mechanism that alters the particles over time, the fade out
'  affector gradually fades the particles out so they are invisible when they
'  are deleted this lets them smoothly vanish instead of poping out of existence
iFadeOutAffector( SmokeParticles, 2000, 16,8,0 )

'  another affector is the gravity affector, this adds a small amount of velocity
'  to the particles each frame, although its called a gravity affector it can
'  be used to push the particles in any direction so you can have drifting smoke
'  bubbling fountains, etc ...
iGravityAffector ( SmokeParticles, 0.05, 0.05, 0.0, 1.0 )

'  another affector is the attractor that can be used to attract or repel
'  particles to a particular point
iAttractionAffector ( SmokeParticles, 10.0, 0.0, 0.0, 20.0, IRR_REPEL, 1, 1, 1 )

iRotationAffector ( SmokeParticles, 0.0, -120.0, 0.0, 0.0,0.0,0.0 )

'  load a grey smoke like image for the particle
ParticleTexture = iLoadTexture( "./media/ParticleGrey.bmp" )

ParticlesNode = SmokeParticles

'  apply the texture to the particles system, this texture will now be drawn
'  across each particles surface
iNodeTexture( ParticlesNode, ParticleTexture, 0 )

'  out particle system is not affected by lighting so we make it self
'  illuminating
iNodeMaterialFlag( ParticlesNode, IRR_EMF_LIGHTING, False )

'  as the particle texture has black borders, each overlapping particle would
'  draw this blackness ontop of one another as a sharp egde they would look like
'  a lot of solid squares instead of the transparent gas effect we are trying
'  to created. so here we change the material type of the node - instead of
'  drawing the node solidly onto the screen it is added onto the colour
'  underneath itself so black doesnt change the color and white would build up
'  top of the existing color until it completly saturates the pixel
iNodeMaterialType ( ParticlesNode, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  add a fixed position camera to the scene so we can view the particle system.
'  the first three parameters are the cameras location, the second three
'  parameters are where the camera is looking at
Camera = iCreateCamera( False )
iPositionNode( Camera, 100, 40, 0 )
iCameraTarget( Camera, 0, 40, 0 )

'  clear the canvas to black to show the particles up better
iCameraCLSColor( 128,200,200 )

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
