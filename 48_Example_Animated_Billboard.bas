'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 48: Animated Billboards
'  This example demonstrates animated billboards. The texture on the billboard
'  is changed each frame to generate an animated surface.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

Const LAST_FRAME = 4

'  irrlicht objects
Dim Billboard As Integer
Dim Camera As Integer
Dim xpos As Single = 0.0
Dim frame As Integer = 50
Dim framesync As Single = 0.0

Dim BillboardTexture( LAST_FRAME ) As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 48: Animated Billboards" )

'  load the texture resource for the billboard
BillboardTexture(1) = iLoadTexture( "./media/1.tga" )
BillboardTexture(2) = iLoadTexture( "./media/2.tga" )
BillboardTexture(3) = iLoadTexture( "./media/3.tga" )
BillboardTexture(4) = iLoadTexture( "./media/4.tga" )

'  add the billboard to the scene, the first two parameters are the size of the
'  billboard in this instance they match the pixel size of the bitmap to give
'  the correct aspect ratio. the last three parameters are the position of the
'  billboard object
Billboard = iCreateBillBoard( 10.0, 10.0,  0.0, 0.0, 0.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeTexture( Billboard, BillboardTexture(1), 0 )

'  rather than have the billboard lit by light sources in the scene we can
'  switch off lighting effects on the model and have it render as if it were
'  self illuminating
iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, False )
iNodeMaterialType ( Billboard, IRR_EMT_TRANSPARENT_ALPHA_CHANNEL )

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateCamera( False )
iPositionNode( Camera, 100, 0, 0 )

'  hide the mouse pointer
iHideMouse()

'  make a note of the time 
framesync = iTime()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 255, 255, 0 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene
    iBeginScene()

     '  move the billboard towards the camera by 0.01 units
    iPositionNode( Billboard, xpos, 0.0, 0.0 )
    xpos = xpos + 0.01

     '  check to see if 0.1 seconds have advanced since we recorded the time
    If iTime() - framesync > 500 Then
         '  record the new time
        framesync = iTime()
         '  advance to the next frame
        frame = frame + 1
         '  if we have passed the last frame rewind to the begining
        If frame > LAST_FRAME Then frame = 1 

         '  change the texture used for the billboard
        iNodeTexture( Billboard, BillboardTexture(frame), 0 )
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
