'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 38 : Dynamic Lighting
'  This example changes the properties of the lighting dynamically as the
'  program runs
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim SphereNode As Integer
Dim NodeTexture As Integer
Dim Material As Integer
Dim Light As Integer
Dim LightAmbient As Integer
Dim Camera As Integer
Dim attenuation As Single = 1.0
Dim red_diffuse As Single = 1.0
Dim green_diffuse As Single = 0.0
Dim blue_diffuse As Single = 0.5
Dim ambient As Single = 0.0

'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  set the window caption
iAppTitle( "Example 38: Dynamic Lighting" )

'  create some simple scene objects
SphereNode = iCreateSphere( 32, False )
iScaleNode( SphereNode, 20, 20, 20 )

'  add a simple point light
Light = iCreateLight( False, -100,100,100, 1.0,1.0,1.0, 600.0 )

'  add a black light used to introduce ambient lighting
LightAmbient = iCreateLight( False, 0,0,0, 0.0,0.0,0.0, 600.0 )

'  add a camera to the scene to view the objects
Camera = iCreateCamera( False )

iPositionNode( Camera, -50,0,0 )

'  we also hide the mouse pointer to see the view better
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 0, 0, 0 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running

While iRun() And (Not iKeyHit( KEY_ESCAPE ))

	 '  begin the scene
	iBeginScene()

	 '  change the diffuse color emitted by the light over time
	iLightDiffuseColor( Light, red_diffuse, green_diffuse, blue_diffuse )
	If red_diffuse > 0.0 Then red_diffuse = red_diffuse - 0.00001
	If green_diffuse < 1.0 Then green_diffuse = green_diffuse + 0.00001
	If blue_diffuse < 1.0 Then blue_diffuse = blue_diffuse + 0.00001
    
	 '  slowly introduce ambient light
	iLightAmbientColor( LightAmbient, ambient, ambient, ambient )
	If ambient < 0.1 Then ambient = ambient + 0.000001
    
	 '  draw the scene
	iDrawScene()
        
	 '  end drawing the scene and render it
	iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
