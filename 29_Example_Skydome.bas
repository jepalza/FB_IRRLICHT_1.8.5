'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 29 : Skydome
'  This example adds a skydome around the whole scene that makes a backdrop
'  for your scene to be rendered against
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim SkyDome As Integer
Dim SkyBox As Integer
Dim Camera As Integer
Dim tex As Integer
Dim tex2 As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iVSync( True )
iIrr3D( 1024, 768, 32, False )

'  send the window caption
iAppTitle( "Example 29: Skydome Day \ Night" )

'  the skydome is a simple hollow sphere that surrounds the whole scene. a single
'  texture is applied to the entire surface of the sphere.
tex = iLoadTexture("./media/Sky_horiz_6-2048.jpg")
tex2 = iLoadTexture("./media/Copy of stars_.bmp")

'  create a sphere
SkyDome = iCreateSphere( 16, False )

'  texture the sphere
iNodeTexture( SkyDome, tex, 0 )
iNodeMaterialType( SkyDome, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  turn on lighting on the sphere
iNodeMaterialFlag( SkyDome, IRR_EMF_LIGHTING, True )

'  turn on lighting on the sphere
iNodeMaterialFlag( SkyDome, IRR_EMF_LIGHTING, True )

'  lets make is big
iScaleNode( SkyDome, 3000, 3000, 3000 )

'  flip the sphere inside out
iFlipNodeMesh( SkyDome )

'  add skybox for night sky
SkyBox = iCreateSkybox(tex2,tex2,tex2,tex2,tex2,tex2)
iNodeMaterialType( SkyBox, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  we add a first person perspective camera to the scene so you can look about
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  hide the mouse pointer
iHideMouse()

'  erase the canvas with sky-blue before rendering
iCameraCLSColor( 0, 0, 0 )

iAmbientLight(1,1,1)

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
Dim SunLight As Single = 1.0
Dim As Integer EsDia = False
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

' 	day \ night cycle
	If EsDia Then	SunLight = SunLight + 0.005
	If EsDia And SunLight > 1.0 Then EsDia = False : SunLight = 1.0
	If (Not EsDia) Then SunLight = SunLight - 0.005
	If (Not EsDia) And SunLight < 0.0 Then EsDia = True : SunLight = 0.0
	iAmbientLight( SunLight, SunLight, SunLight )
		
     '  draw the scene
	 '  first lets center the skydome on the camera
	iPositionNode( SkyDome, iNodeX( Camera, True ), iNodeY( Camera, True ), iNodeZ( Camera, True ) )

    iDrawScene()

     '  end drawing the scene and render it
    iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
