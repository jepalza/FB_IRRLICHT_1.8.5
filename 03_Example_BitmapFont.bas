'  '  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 03: Bitmap Fonts
'  This example uses a bitmap based font to draw text to the screen
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
'  This wrapper uses a series of types to bring type errors to your attention
'  when passing variables into the wrapper

Dim BitmapFont As Integer

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface. The scene will be rendered using the Irrlicht,
'  software renderer, the display will be a window 400 x 200 pixels in size, the
'  display will not support shadows and we will not capture any keyboard and
'  mouse events
iIrr3D( 640, 480, 32, False )

'  Set the title of the display
iAppTitle( "Example 03: Bitmap Fonts" )

'  load a bitmap font as a texture
BitmapFont = iLoadFont ( "./media/bitmapfont.bmp" )

'  erase the canvas to black before rendering
iCameraCLSColor( 0,0,0 )

'  while the scene is still running
While iRun() And (Not iKeyHit(KEY_ESCAPE))
    iBeginScene()

     '  draw the text using the loaded bitmap font at the supplied co-ordinates
     '  this font only has capitals in the bitmap at the moment lowercase
     '  characters will display as blanks
    iText ( BitmapFont, "SIMPLE MONOCHROME FONT", 120, 80, 250, 96 )

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End
