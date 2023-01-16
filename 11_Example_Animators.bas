'' ----------------------------------------------------------------------------
'' Irrlicht Wrapper For Imperative Languages - Freebasic Examples
'' Frank Dodd (2006)
'' ----------------------------------------------------------------------------
'' Coverted To Blitzplus And Irrlicht 1.8.1 by AquaLung (2014)
'' ----------------------------------------------------------------------------
'' Example 11 : Animators
'' This example demonstrates animators, these are mechanisms applied To nodes
'' in the scene that Animate the Object in some manner over time. this wrapper
'' exposes six animators five of which are shown here
'' ----------------------------------------------------------------------------

'' ////////////////////////////////////////////////////////////////////////////
'' Includes For extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'' ////////////////////////////////////////////////////////////////////////////

' irrlicht objects
Dim Shared BoxTexture As Integer
Dim Shared FloorBox As Integer
Dim Shared AnimatedBox( 5 ) As Integer
Dim Shared DeletedBox As Integer
Dim Shared CircleBox As Integer
Dim Shared FlyBox As Integer
Dim Shared RotateBox As Integer
Dim Shared SplineBox As Integer
Dim Shared ret As Integer
Dim Shared Camera As Integer
Dim Shared sx( 4 ) as single
Dim Shared sy( 4 ) as single
Dim Shared sz( 4 ) as single
Dim Shared box_index As Integer


'' ////////////////////////////////////////////////////////////////////////////
' start the irrlicht interface
iIrr3D( 640, 480, 32, False )

' send the window caption
iAppTitle( "Example 11: Animators" )

' add a bright ambient light To the scene To brighten everything up
iAmbientLight( 1,1,1 )

' first lets Load a texture that we can use on the test boxes in the scene
BoxTexture = iLoadTexture( "./media/freebasiclogo_big.jpg" )

' loop around And set up 5 boxes so we can show each of the animators
For box_index = 1 To 5
    ' Create the box
    AnimatedBox(box_index) = iCreateCube( 8, IRR_NO_OBJECT )
    ' texture the box
    iNodeTexture( AnimatedBox(box_index), BoxTexture, 0 )
    ' scale the box up To a visible size
    iScaleNode( AnimatedBox(box_index), 2.5,2.5,2.5 )
Next


' this animator will Delete the box after a specified number of milliseconds
' have passed, in this Case 5 seconds
ret = iDeleteAnimator( AnimatedBox(1), 5000 )


' this animator will fly the box around in a circle, the first 3 parameters
' specify the center of the circle, the Next specifies the radius of the circle
' And finally a speed parameter To specify how far the box is moved each frame
ret = iFlyCircleAnimator( AnimatedBox(2), 0,50,0, 50, 0.001 )


' this animator will fly the box in a straight line, the first three parameters
' specify the start position, the Next three the End position, the Next number
' is the number of milliseconds it takes To fly the path (in this Case 3
' seconds) And finally you can specify If it is To fly the path once Or To loop
' around flying it endlessly
ret = iFlyStraightAnimator( AnimatedBox(3), 0,50,-300, 0,50,300, 3000, IRR_LOOP )


' this animator will spin the box around its centre, its very easy To set up
' And simply consists of the speed its To be rotated each frame
ret = iRotationAnimator( AnimatedBox(4), 0, 0.1, 0 )

' we move this box out of the way also so it doesnt obscure the deleted box
iPositionNode( AnimatedBox(4), 0,100,0 )


' the last animator is the Spline Animator, its more difficult To set up but
' is very natural looking And powerful. A spline is a curved line that passed
' through Or close To a list of co-ordinates, creating a smooth flight.

' this animator needs a list of coordinates stored in three arrays, one array
' each For the X, Y And Z locations of all the points. The arrays defined here
' Create a 4 point circle that wobbles up And down a bit. another good way To
' get co-ordinates is To Load in the camera position example And move your
' camera To a point And write down its co-ordinates, this is particularly good
' For getting points on a map
sx(1) = -100
sy(1) = 50
sz(1) = 0

sx(2) = 0
sy(2) = 100
sz(2) = -100

sx(3) = 100
sy(3) = 50
sz(3) = 0

sx(4) = 0
sy(4) = 100
sz(4) = 100

Dim BoxNode As Integer = AnimatedBox(5)

' once the points are defined we can Create the animator first we tell it how
' many points are in the list (in this Case 4) Then we pass the first element
' of the array of points For each of the x, y And z arrays, the Next parameter
' defines the starting point on the curve, the Next the speed the node travels
' along the curve And the Final number specifies how tightly the curve is tied
' To the points (0 is angular And 1 is loose)
' params:node,array_size,x,y,z,time_to_start,speed,tightness

ret = iSplineAnimator( BoxNode, 4, @sx(1), @sy(1), @sz(1), 0, 0.5, 1)

' add a static camera To the scene To observe the animation
Camera = iCreateCamera( IRR_NO_OBJECT )
iPositionNode( Camera, 150, 50, 0 )
iCameraTarget( Camera, 0, 50, 0 )

' erase the canvas with sky-blue before rendering
iCameraCLSColor( 128, 255, 255 )

' -----------------------------------------------------------------------------
' While the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))
    ' begin the scene
    iBeginScene()

    ' draw the scene
    iDrawScene()

    ' End drawing the scene And render it
    iEndScene()
Wend

' -----------------------------------------------------------------------------
' Stop the irrlicht engine And Release resources
iEndIrr3D()

End
