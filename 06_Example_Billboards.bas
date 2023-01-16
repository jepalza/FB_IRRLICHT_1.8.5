'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 06: Billboards
'  This example demonstrates Billboards. A billboard is a single rectangular
'  polygon that always faces the camera. It is often referred to as a 3D sprite
'  and is especially good for spherical effects like glowing floating lights
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Billboard As Integer
Dim BillboardTexture As Integer
Dim Camera As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 06: Billboards" )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/BlitzLogo_Big.jpg" )

'  add the billboard to the scene, the first two parameters are the size of the
'  billboard in this instance they match the pixel size of the bitmap to give
'  the correct aspect ratio. the last three parameters are the position of the
'  billboard object
Billboard = iCreateBillBoard( 200.0,102, 0.0,0.0,100.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeTexture( Billboard, BillboardTexture, 0 )

'  rather than have the billboard lit by light sources in the scene we can
'  switch off lighting effects on the model and have it render as if it were
'  self illuminating
iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, False )

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )

'  hide the mouse pointer
iHideMouse()

' , erasing the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )
'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
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
