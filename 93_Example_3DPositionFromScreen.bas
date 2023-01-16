'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 93 : 3D Position from Screen Coordinates
'  This example demonstrates how to get a 3D position in space from a set of
'  screen coordinates and the definition of a 2D plane in 3D space. this can
'  be particularly useful in a scene management application for constraining
'  the movement of an object to a specific axis
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim MyTexture As Integer
Dim CenterNode As Integer
Dim IndicatorObject As Integer
Dim Camera As Integer
Dim XPOS As Single
Dim YPOS As Single
Dim ZPOS As Single
Dim normalX As Single = 0.0
Dim normalY As Single = 0.0
Dim normalZ As Single = 1.0


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 93 : 3D Position from Screen Coordinates" )

'  add a bright ambient light to the scene to brighten everything up
iAmbientLight( 1,1,1 )

'  first load a texture
MyTexture = iLoadTexture( "./media/texture.jpg" )

'  add a simple test node so we can visualise the world origin
CenterNode = iCreateCube( 8, False )

'  texture the node
iNodeTexture( CenterNode, MyTexture, 0 )


'  add a sphere object that will mark the point in 3D space
'  the sphere we create has a radius of 10.0 and is made from rings of 12
'  verticies
IndicatorObject = iCreateSphere( 10.0, False ) ' , 12)
iScaleNode( IndicatorObject, 5, 5, 5 )

'  texture the sphere
iNodeTexture( IndicatorObject, MyTexture, 0 )

'  add a static camera to the scene
Camera = iCreateCamera( False )
iPositionNode( Camera, 100, 100, 100 )

'  Hide the mouse pointer
iHideMouse()

iCameraCLSColor( 255, 255, 255 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

	 '  begin the scene
	iBeginScene()
    
	If iKeyHit( KEY_KEY_X ) Then
		normalX  = 1.0
		normalY  = 0.0
		normalZ  = 0.0
	End If
	
	If iKeyHit( KEY_KEY_Y ) Then 
		normalX  = 0.0
		normalY  = 1.0
		normalZ  = 0.0
	End If
	
	If iKeyHit( KEY_KEY_Z ) then
		normalX  = 0.0
		normalY  = 0.0
		normalZ  = 1.0
	End If
	
Dim 	MX As Integer = iMouseX()
Dim 	MY As Integer = iMouseY()
	
	 '  get the position of the object projected against the plane
	XPOS = i3DPositionXFromScreen( MX, MY, Camera, normalX, normalY, normalZ, 0.0 )
	YPOS = i3DPositionYFromScreen( MX, MY, Camera, normalX, normalY, normalZ, 0.0 )
	ZPOS = i3DPositionZFromScreen( MX, MY, Camera, normalX, normalY, normalZ, 0.0 )
	
	 '  update the position of the indicator object
	iPositionNode( IndicatorObject, XPOS , YPOS, ZPOS )

	 '  draw the scene
	iDrawScene()

	 '  end drawing the scene and render it
	iEndScene()     

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
