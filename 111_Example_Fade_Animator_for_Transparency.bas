'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 111: Fade Animator for Transparency
'  This example demonstrates the fade animator applied to transparent nodes.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Billboard(3) As Integer
Dim BillboardTexture As Integer
Dim Camera As Integer

Dim frames As integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iUseOpenGL()
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 111: Fade Animator for Transparency" )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/beam.png" )

'  add the billboard to the scene, the first two parameters are the size of the
'  billboard in this instance they match the pixel size of the bitmap to give
'  the correct aspect ratio. the last three parameters are the position of the
'  billboard object
Billboard(1) = iCreateBillBoard( 30.0,100.0, -30.0,0.0,100.0 )
Billboard(2) = iCreateBillBoard( 30.0,100.0,   0.0,0.0,100.0 )
Billboard(3) = iCreateBillBoard( 30.0,100.0,  30.0,0.0,100.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeTexture( Billboard(1), BillboardTexture, 0 )
iNodeTexture( Billboard(2), BillboardTexture, 0 )
iNodeTexture( Billboard(3), BillboardTexture, 0 )

'  fading requires that lighting is enabled
iNodeMaterialFlag( Billboard(1), IRR_EMF_LIGHTING, True )
iNodeMaterialFlag( Billboard(2), IRR_EMF_LIGHTING, True )
iNodeMaterialFlag( Billboard(3), IRR_EMF_LIGHTING, True )

'  apply transparent materials types
iNodeMaterialType ( Billboard(1), IRR_EMT_TRANSPARENT_ADD_COLOR )
iNodeMaterialType ( Billboard(2), IRR_EMT_TRANSPARENT_ALPHA_CHANNEL )
iNodeMaterialType ( Billboard(3), IRR_EMT_TRANSPARENT_ALPHA_CHANNEL_REF )

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateCamera( False )
iCameraTarget( Camera, 50, 0, 20 )

'  hide the mouse pointer
iHideMouse()

'  set the ambient light level across the entire scene
iAmbientLight( 1,1,1 )

iScaleNode( Billboard(1), 0.5,0.5,0.5 )

iCameraCLSColor( 128, 128, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

          '  begin the scene, erasing the canvas with sky-blue before rendering
        iBeginScene()
    
         '  draw the scene
        iDrawScene()
    
         '  end drawing the scene and render it
        iEndScene()
        
         '  wait until 100 frames have elapsed
        frames = frames + 1
        If frames = 100 Then
             '  Add the fade, scale and delete animator
            iFadeAnimator( Billboard(1), 3000, -0.5 )       '  shrink
            iFadeAnimator( Billboard(2), 3000,  0.0 )       '  dont scale
            iFadeAnimator( Billboard(3), 3000,  0.5 )       '  expand
        EndIf

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
