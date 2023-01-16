'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 23: Testing for Video Features
'  This example performs each of the available tests on the video capabilities
'  of the graphics card. It is often useful to know which features the card
'  will support so that you can apply the appropriate materials to your objects
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


Dim Results(32) As String

'  ////////////////////////////////////////////////////////////////////////////
'  global variables
'  ////////////////////////////////////////////////////////////////////////////

'  start the irrlicht interface.
iIrr3D( 400, 700, 32, False )

'  Set the title of the display
iAppTitle( "Example 23: Video Feature Test" )
iColor( 255,0,0,0 )
iCameraCLSColor( 200,200,200 )
	
'  Query each of the video features and display whether they are available

If iQueryFeature( EVDF_RENDER_TO_TARGET ) = 1 Then
    Results(1) = "The driver is able To render To a surface"
Else
    Results(1) = "The driver is NOT able to render to a surface"
End If 

If iQueryFeature( EVDF_HARDWARE_TL ) = 1 Then
    Results(2) = "Hardeware transform and lighting is supported"
Else
    Results(2) = "Hardeware transform and lighting is NOT supported"
End If 

If iQueryFeature( EVDF_MULTITEXTURE ) = 1 Then
    Results(3) = "Multiple textures per material are possible"
Else
    Results(3) = "Multiple textures per material are NOT possible"
End If 

If iQueryFeature( EVDF_BILINEAR_FILTER ) = 1 Then
    Results(4) = "The driver is able to render with a bilinear filter applied"
Else
    Results(4) = "The driver is NOT able to render with a bilinear filter applied"
End If 

If iQueryFeature( EVDF_MIP_MAP ) = 1 Then
    Results(5) = "The driver can handle mip maps"
Else
    Results(5) = "The driver can NOT handle mip maps"
End If 

If iQueryFeature( EVDF_MIP_MAP_AUTO_UPDATE ) = 1 Then
    Results(6) = "The driver can update mip maps automatically"
Else
    Results(6) = "The driver can NOT update mip maps automatically"
End If 

If iQueryFeature( EVDF_STENCIL_BUFFER ) = 1 Then
    Results(7) = "Stencilbuffers are switched on and the device does support stencil buffers"
Else
    Results(7) = "Stencilbuffers are NOT switched on or are unsupported"
End If 

If iQueryFeature( EVDF_VERTEX_SHADER_1_1 ) = 1 Then
    Results(8) = "Vertex Shader 1.1 is supported"
Else
    Results(8) = "Vertex Shader 1.1 is NOT supported"
End If 

If iQueryFeature( EVDF_VERTEX_SHADER_2_0 ) = 1 Then
    Results(9) = "Vertex Shader 2.0 is supported"
Else
   Results(9) = "Vertex Shader 2.0 is NOT supported"
End If 

If iQueryFeature( EVDF_VERTEX_SHADER_3_0 ) = 1 Then
    Results(10) = "Vertex Shader 3.0 is supported"
Else
    Results(10) = "Vertex Shader 3.0 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_1_1 ) = 1 Then
    Results(11) = "Pixel Shader 1.1 is supported"
Else
    Results(11) = "Pixel Shader 1.1 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_1_2 ) = 1 Then
    Results(12) = "Pixel Shader 1.2 is supported"
Else
    Results(12) = "Pixel Shader 1.2 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_1_3 ) = 1 Then
    Results(13) = "Pixel Shader 1.3 is supported"
Else
    Results(13) = "Pixel Shader 1.3 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_1_4 ) = 1 Then
    Results(14) = "Pixel Shader 1.4 is supported"
Else
    Results(14) = "Pixel Shader 1.4 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_2_0 ) = 1 Then
    Results(15) = "Pixel Shader 2.0 is supported"
Else
    Results(15) = "Pixel Shader 2.0 is NOT supported"
End If 

If iQueryFeature( EVDF_PIXEL_SHADER_3_0 ) = 1 Then
    Results(16) = "Pixel Shader 3.0 is supported"
Else
    Results(16) = "Pixel Shader 3.0 is NOT supported"
End If 

If iQueryFeature( EVDF_ARB_VERTEX_PROGRAM_1 ) = 1 Then
    Results(17) = "ARB vertex programs v1.0 are supported"
Else
    Results(17) = "ARB vertex programs v1.0 are NOT supported"
End If 

If iQueryFeature( EVDF_ARB_FRAGMENT_PROGRAM_1 ) = 1 Then
    Results(18) = "ARB fragment programs v1.0 are supported"
Else
    Results(18) = "ARB fragment programs v1.0 are NOT supported"
End If 

If iQueryFeature( EVDF_ARB_GLSL ) = 1 Then
    Results(19) = "GLSL is supported"
Else
    Results(19) = "GLSL is NOT supported"
End If 

If iQueryFeature( EVDF_HLSL ) = 1 Then
    Results(20) = "HLSL is supported"
Else
    Results(20) = "HLSL is NOT supported"
End If 

If iQueryFeature( EVDF_TEXTURE_NPOT ) = 1 Then
    Results(21) = "non-power-of-two textures are supported"
Else
    Results(21) = "non-power-of-two textures are NOT supported"
End If 

If iQueryFeature( EVDF_FRAMEBUFFER_OBJECT ) = 1 Then
    Results(22) = "framebuffer objects are supported"
Else
    Results(22) = "framebuffer objects are NOT supported"
End If 

If iQueryFeature( EVDF_VERTEX_BUFFER_OBJECT ) = 1 Then
    Results(23) = "vertex buffer objects are supported"
Else
    Results(23) = "vertex buffer objects are NOT supported"
End If 

If iQueryFeature( EVDF_ALPHA_TO_COVERAGE ) = 1 Then
    Results(24) = "alpha to coverage is supported"
Else
    Results(24) = "alpha to coverage is NOT supported"
End If 

If iQueryFeature( EVDF_COLOR_MASK ) = 1 Then
    Results(25) = "color masks are supported"
Else
    Results(25) = "color masks are NOT supported"
End If 

If iQueryFeature( EVDF_MULTIPLE_RENDER_TARGETS ) = 1 Then
    Results(26) = "multiple render targets are supported"
Else
    Results(26) = "multiple render targets are NOT supported"
End If 

If iQueryFeature( EVDF_MRT_BLEND ) = 1 Then
    Results(27) = "seperate blend settings for render targets are supported"
Else
    Results(27) = "seperate blend settings for render targets are NOT supported"
End If 

If iQueryFeature( EVDF_MRT_COLOR_MASK ) = 1 Then
    Results(28) = "seperate color masks for render targets are supported"
Else
    Results(28) = "seperate color masks for render targets are NOT supported"
End If 

If iQueryFeature( EVDF_MRT_BLEND_FUNC ) = 1 Then
    Results(29) = "seperate blend functions for render targets are supported"
Else
    Results(29) = "seperate blend functions for render targets are NOT supported"
End If 

If iQueryFeature( EVDF_GEOMETRY_SHADER ) = 1 Then
    Results(30) = "geometry shaders are supported"
Else
    Results(30) = "geometry shaders are NOT supported"
End If 

Dim y As integer
Dim i As integer
While iRun() And (Not iKeyHit(KEY_ESCAPE))

	iBeginScene()
	
	iDrawScene()
	
	y = 5
	For i = 1 To 30
		iText(0,Results(i),10,y,100,y+20)
		y = y + 20
	Next
	
	iEndScene()
	
Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()



End
