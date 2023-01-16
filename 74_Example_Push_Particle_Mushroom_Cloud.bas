'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 74: Push Particle Mushroom Cloud
'  This example demonstrates the use of the push particle affector to create a
'  mushroom cloud like effect.
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
Dim fade As Single
Dim FadeOut As Integer
Dim affectorA As Integer
Dim affectorB As Integer
Dim CenterY As Single
Dim TimeSecs As Integer = 0
Dim TimeMs As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 74: Mushroom cloud with the Push Affector" )

'  this adds a small test node to the scene, a test node is a simple cube, that
'  you can move and texture like any other object however there is another
'  reason for adding this node. the particle system needs another node rendered
'  onto the display to allow it to display material effects. this may be an issue
'  with the wrapper that needs investigation
TestNode = iCreateCube (8, False )

'  set up a particle system that generates a stream of smoke please see example
'  Seven for detailed information
SmokeParticles = iCreateParticleSystem( False,0,-1,0,0,0,0,0,0,1,1,1 )

'  finally we add this particle emitting object to the particle system, usually
'  it would be a good idea to add a fade out affector here but as the smoke
'  particles are going to be pushed back into the column of smoke when they
'  die we wont be able to see them anyway and as we have a lot of particles the
'  less affectors we can get away with the more CPU we will have left
SmokeEmitter = iCreateParticleEmitter( SmokeParticles, -7, 0, -7, 7, 7, 7, 0, 0, 0, 10, 10, 255, 255, 255, 255, 255, 255, 25000, 25000, 15.0, 15.0, 15.0, 15.0, 15 )

'  push the particles upward for 100 units above the affector. the push is
'  strongest at the center of the effect and diminishes to zero when its 100
'  units away, the radial effect is OFF so all particles are pushed in the same
'  direction with the same force as if they were affected by gravity.
'  this affector also has a column width, this limits the effect into a vertical
'  column, effectivly making this push affector like a cylinder 100 units high
'  and 20 units in radius, similar to a fountain
iPushAffector ( SmokeParticles, 0, 0, 0, 0, 30, 0, 100.0, 0.0, 20.0, False )

'  this affector pushes from above the particles it has a weaker downward force,
'  only 8 units, but it also pushes the particles outwards, the radial effect is
'  ON so the particles will be pushed away from the center of the effect, so as
'  the particles get higher they will get closer to this effect and will be
'  pushed outwards more and more.
'  as the affector above is a column the particles will get shoved out of the
'  effect of the column and the small downward force will begin to take over and
'   slowly push the particles down
affectorA = iPushAffector ( SmokeParticles, 0, 100, 0, 60, 18, 60, 75, 0.0, 0.0, True )

'  this final affector simulates the suction of the vaccum left by the rising
'  smoke pushing the particles back into the column, it has a small inward force,
'  it is a radial effect so it draws particles in towards its center.
'  unlike the other affectors this has a near distance, the near distance acts
'  just like the far distance, as particles get closer to the near distance the
'  effect gets weaker so in this example the force is zero at 50.0 and 15.0 units
'  and strongest in the middle of the numbers at 32.5 units.
'  this  ' ring; like affector will push the particles back into the column but
'  wont squash them to a point at its center and they will also have very little
'  effect on the column of particles that rise through its center at the start
affectorB = iPushAffector ( SmokeParticles, 0, 50, 0, -18, 0, -8, 50.0, 15.0, 0.0, True )

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
iCameraCLSColor( 5, 5, 5 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running and less than 30 seconds has
'  elapsed
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  calculate some values based on the time in milliseconds (1/1000th second)
    TimeMs = iTime()

     '  this is the height of the base of the mushroom cloud, it is based on the
     '  center of the suction effect. it is 25 units plus 0.003 units for every
     '  milisecond that passes
    CenterY = 25.0 + 0.003 * TimeMs

     '  this is the number of seconds that have elapsed
    TimeSecs = TimeMs / 1000

     '  if the number of elapsed seconds is less than 21
    If TimeSecs < 21 Then
         '  slowly reduce the rate that the smoke particles are emitted, we start
         '  at the maxium rate of 20 a second and as time passes and the number
         '  of elapsed seconds passes less and less particles are emitted
        iEmitterMinParticlesPerSecond( SmokeEmitter, 20 - TimeSecs )
        iEmitterMaxParticlesPerSecond( SmokeEmitter, 20 - TimeSecs )
    End If 

     '  here we set the center of the suction effect and the center of the push
     '  outwards effect, the center rises slowly over time and this makes the
     '  top of the mushroom effect rise slowly too, 50 units is kept between the
     '  two effects this is basically the height of the mushrooms ;cap;
    iCenterOfEffect( affectorA, 0, CenterY + 50.0, 0 )
    iCenterOfEffect( affectorB, 0, CenterY, 0 )

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and display it
    iEndScene()
Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
