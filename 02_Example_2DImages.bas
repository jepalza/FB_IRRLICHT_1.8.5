'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 02: 2D Images
'  This example uses a range of 2D image drawing operations to draw graphics
'  on the display
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
'  This wrapper uses a series of types to bring type errors to your attention
'  when passing variables into the wrapper
Dim IrrlichtLogo As Integer
Dim BlitzLogo As Integer
Dim WrapperLogo As Integer
Dim screen_width As Integer
Dim screen_height As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface. The scene will be rendered using the Irrlicht,
'  software renderer, the display will be a window 400 x 200 pixels in size, the
'  display will not support shadows and we will not capture any keyboard and
'  mouse events
screen_width = 640
screen_height = 480
iIrr3D( screen_width, screen_height, 32, False )

'  Set the title of the display
iAppTitle( "Example 02: 2D Images" )

'  load bitmap images of important Open Source tools used in this development
'  and store them in irrlicht texture objects
IrrlichtLogo = iLoadTexture( "./media/irrlichtlogo.png" )
BlitzLogo = iLoadTexture( "./media/Blitzlogo.bmp" )
WrapperLogo = iLoadTexture( "./media/BlitzIrrlichtLogoSM.png" )

'  create a mask for the Irrlicht logo that makes the white areas of the 
'  logo transparent
iMaskTexture( IrrlichtLogo, 255, 255, 255, 0 )

'  erase the canvas To Yellow Before rendering
iCameraCLSColor(255,255,0)

'  while the scene is still running
While iRun() And (Not iKeyHit(KEY_ESCAPE))
     '  begin the scene
    iBeginScene()

     '  the basic 2D drawing operation copies the whole texture to the screen
     '  at the specified co-ordinates
    iDrawImage( IrrlichtLogo, 1, 4 )

     '  a more flexible method for drawing to the screen this copies a rectangular
     '  area of the texture to the screen and can use a color keyed mask or an
     '  alpha channel in the image to make parts of the image transparent.
     '  first supply the texture, then the destination co-ordinates, then the
     '  co-ordinates of the rectangular area to copy and finally a flag to
     '  specify whether to use the alpha channel for transparency
    iDrawImageElement( IrrlichtLogo, screen_width - 257,4,0,0,256,74, False )
    iDrawImageElement( BlitzLogo,4, screen_height - 32 - 4,0,0,80,24, False )
    iDrawImageElement( WrapperLogo,( screen_width - 110 ) / 2, screen_height - 32 - 4,0,0,100,32, True )
    iDrawImageElement( WrapperLogo,screen_width - 110 - 4, screen_height - 32 - 4,0,0,100,32, False )

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
