'' ----------------------------------------------------------------------------
' Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
' ----------------------------------------------------------------------------
' SOUND Example : IRRKLANG 3D EXAMPLE
' This example creates a moving sphere that emits 3D music
' ----------------------------------------------------------------------------


' Include
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


' Variables

Dim As Integer Music
Dim As Integer SoundSphere
Dim As Integer Camera
Dim As Integer AnimateSphere

Dim As Integer Terrain
Dim As Integer Terrain_Collision

Dim As Single CameraX
Dim As Single CameraY
Dim As Single CameraZ

Dim As Single CameraTargetX
Dim As Single CameraTargetY
Dim As Single CameraTargetZ

' start the irrlicht interface
iIrr3D( 800,600, 32, FALSE )
iAppTitle("IrrKlang 3D Test")

SoundSphere = iCreateSphere( 16, FALSE )
iScaleNode( SoundSphere, 10, 10, 10 )
iNodeColor( SoundSphere, 255, 0, 0, 255 )
AnimateSphere = iFlyCircleAnimator( SoundSphere, 1000, 50, 1000, 100, 0.001 )

Camera = iCreateFPSCamera( 0,100.0,0.5,-1,0,0,0,0.0 )
iPositionNode( Camera, 1000, 500, 1000 )

' path,  xPosition,yPosition,zPosition,  xRotation,yRotation,zRotation,  xScale,yScale,zScale
' vertexalpha,vertexRed,vertexGreen,vertexBlue,  smoothing,maxLOD,patchSize
Terrain = iLoadTerrain("./Media/iheight.jpg",  0,0,0,  0,0,0, 1,1,1,  255,255,255,255,  0,5,ETPS_17 )
iNodeMaterialFlag( Terrain, IRR_EMF_LIGHTING, FALSE )
iNodeTexture( Terrain, iLoadTexture( "./Media/detailmap-dim.jpg" ), 0 )
iScaleNode( Terrain, 10.0, 0.0, 10.0 )
Terrain_Collision = iGetCollisionGroupFromTerrain ( Terrain, 0 )
iCollisionAnimator( Terrain_Collision, Camera, 20, 20, 20, 0.0, -3.0, 0.0, 0.0, 20, 0.0 )

' start the irrklang interface
iKlangInit()

Music = iPlay3DSound( "./Media/getout.ogg", 0, 0, 0, True, False, True, ESM_AUTO_DETECT, FALSE )
iSoundDistance( Music, 100 )

iCameraCLSColor( 158, 204, 226 )
iHideMouse()

While iRun() And (Not iKeyHit( KEY_ESCAPE ))

	iBeginScene()
	
	iDrawScene()

	iPositionSound( Music, iNodeX( SoundSphere, TRUE ),iNodeY( SoundSphere, TRUE ), iNodeZ( SoundSphere, TRUE ) )

	CameraX = iNodeX( Camera, True )
	CameraY = iNodeY( Camera, True )
	CameraZ = iNodeZ( Camera, True )
	CameraTargetX = iCameraTargetX( Camera )
	CameraTargetY = iCameraTargetY( Camera )
	CameraTargetZ = iCameraTargetZ( Camera )
	iListenerPosition( CameraX, CameraY, CameraZ, CameraTargetX, CameraTargetY, CameraTargetZ, 0, 0, 0, 0,1,0 )
	
	iEndScene()
	
Wend 

iKlangEnd()
iEndIrr3D()

End