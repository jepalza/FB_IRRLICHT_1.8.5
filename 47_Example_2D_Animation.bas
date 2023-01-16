'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 47: Animation with 2D Images
'  This example draws a sequence of 2D images to the screen generating an
'  animation
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
'  This wrapper uses a series of types to bring type errors to your attention
'  when passing variables into the wrapper
Dim AnimationStrip As Integer
Dim screen_width As Integer
Dim screen_height As Integer
Dim frame As Integer = 0
Dim framesync As Single = 0

Const LAST_FRAME = 4

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface. The scene will be rendered using the Irrlicht,
'  software renderer, the display will be a window 400 x 200 pixels in size, the
'  display will not support shadows and we will not capture any keyboard and
'  mouse events
screen_width = 800
screen_height = 600
iIrr3D( screen_width, screen_height, 32, False )

'  Set the title of the display
iAppTitle( "Example 47: 2D Animation" )

'  load bitmap images of important Open Source tools used in this development
'  and store them in irrlicht texture objects
AnimationStrip = iLoadTexture( "./media/strip.tga" )

'  make a note of the time 
framesync = iTime() ' Timer

'  erase the canvas to Yellow before rendering
iCameraCLSColor( 255,255,0 )

'  while the scene is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
     '  begin the scene
    iBeginScene()

     '  first supply the texture, then the destination co-ordinates, then the
     '  co-ordinates of the rectangular area to copy and finally a flag to
     '  specify whether to use the alpha channel for transparency
    iDrawImageElement( AnimationStrip, (screen_width - 32) / 2, (screen_height - 32) / 2,frame * 64, 0, ( frame + 1 ) * 64 - 1, 63, True )

     '  check to see if 0.1 seconds have advanced since we recorded the time
    If iTime() - framesync > 500 Then
         '  record the new time
        framesync = iTime()
         '  advance to the next frame
        frame = frame + 1
         '  if we have passed the last frame rewind to the begining
        If frame >= LAST_FRAME Then frame = 0
    EndIf

     '  end drawing the scene and render it
    iEndScene()
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()

End 
