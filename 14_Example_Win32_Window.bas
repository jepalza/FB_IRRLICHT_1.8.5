

#include "windows.bi"
#include "win\commctrl.bi"


#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"

Dim Shared As Integer Win_Alto,Win_Ancho
Win_Ancho=800
Win_Alto=600


' para ventanas HIJO
Dim Shared As HINSTANCE hInstGlobal 

Declare Function ChildWndProc(hWnd_ As HWND , Msg_ As UINT , wParam_ As WPARAM , lParam_ As LPARAM) As LRESULT 
Declare Function CreateNewMDIChildWindow(szTitle As LPTSTR , lpData As LPVOID ) As HWND 

Declare function        WinMain     ( byval hInstance_ as HINSTANCE, _
                                      byval hPrevInstance as HINSTANCE, _
                                      ByVal szCmdLine as string, _
                                      byval iCmdShow as integer ) as integer
                           
End WinMain( GetModuleHandle( null ), null, Command, SW_NORMAL )


Function WndProc ( byval hWnd_ as HWND, _
                   byval wMsg_ as UINT, _
                   byval wParam_ as WPARAM, _
                   byval lParam_ as LPARAM ) as LRESULT

    function = 0
    
    select case wMsg_

            
    	Case WM_CREATE    
 
 			' creamos un BUTTON en la ventana WIN32 para usarlo como ventana grafica del IRRLICHT
     		Dim As HWND hIrrlichtWindow = CreateWindow("BUTTON", "", _
            WS_CHILD or WS_VISIBLE Or BS_OWNERDRAW, _
            30, 30, 640, 480, hWnd_, NULL, hInstGlobal, NULL)

 			' ventana Irrlicht, parametros "iIrr3DAdvanced"
   		'   FrameBuffer,drivertype, scrWidth, scrHeight, bits, fullscreen, shadows, dontignoreinput, 
   		'                vsyncenabled, devicetype, doublebufferenabled, antialiasenabled, highprecisionfpu
   		iIrr3DAdvanced(cast(Any ptr ,hIrrlichtWindow),IRR_EDT_DIRECT3D9,FALSE,FALSE,32,FALSE,FALSE,FALSE, _
   								FALSE,EIDT_BEST,1,FALSE,FALSE) ' o usar EIDT_WIN32
   		' el primer parametro es nuevo, integrado por mi, y emplea un BUTTON creado en WIN32 como ventana grafica
   		' la resolucion es FALSE (ancho y alto) por que emplea la que crea el BUTTON (en este caso, 640x480)
		   Return 0
    
    	Case WM_KEYDOWN
			if( lobyte( wParam_ ) = 27 ) then
				PostMessage( hWnd_, WM_CLOSE, 0, 0 )
			end If
			Return 0

    	Case WM_DESTROY
          PostQuitMessage( 0 )
          ' cierra IRRLICHT
          iEndIrr3D()
          Return 0

    end select
    
    ' Message doesn't concern us, send it to the default handler and get result
    Function = DefWindowProc( hWnd_, wMsg_, wParam_, lParam_ )    
    
end function



function WinMain ( byval hInstance_ as HINSTANCE, _
                   byval hPrevInstance as HINSTANCE, _
                   ByVal szCmdLine as string, _
                   byval iCmdShow as integer ) as integer    
     
	function = 0

	hInstGlobal=hInstance_

    ' Ventana principal "PADRE"
    dim wcls_main as WNDCLASSEX    
    dim Nombre_WIN as String
    dim hWnd_Main as HWND
    Nombre_WIN = "Ventana IRRLICHT"
     
    with wcls_main
    	.cbSize			= SizeOf(WNDCLASSEX) ' param. exclusivo de 'RegisterClassEx', el modo 'RegisterClass' no lo emplea
     	.style         = CS_HREDRAW or CS_VREDRAW
     	.lpfnWndProc   = @WndProc
     	.cbClsExtra    = 0
     	.cbWndExtra    = 0
     	.hInstance     = hInstGlobal
     	.hIcon         = LoadIcon( NULL , IDI_APPLICATION )
     	.hCursor       = LoadCursor( NULL , IDC_ARROW )
     	.hbrBackground = GetStockObject( WHITE_BRUSH )
     	.lpszMenuName  = NULL
     	.lpszClassName = strptr( Nombre_WIN )
     	.hIconSm       = NULL
    end with
     
    ' Registra la clase ventana principal     
    if ( RegisterClassEx( @wcls_main ) = FALSE ) then
			MessageBox( null, "Error Creando Ventana.", Nombre_WIN, MB_ICONERROR )
       	exit function
    end If
    
    
    ' centramos inicio de ventana segun el tamaño deseado
    Dim As Integer IniX = (GetSystemMetrics(SM_CXSCREEN) - Win_Ancho) / 2
    Dim As Integer IniY = (GetSystemMetrics(SM_CYSCREEN) - Win_Alto ) / 2 
    
    ' crea la ventana "padre" y la muestra (WS_VISIBLE)
    hWnd_Main = CreateWindowEx( 0, _
    			 		   		Nombre_WIN, _
                           "Ventana Principal", _
                           WS_OVERLAPPEDWINDOW , _
                           IniX, _
                           IniY, _
                           Win_Ancho, _
                           Win_Alto, _
                           NULL , _
                           NULL , _
                           hInstGlobal, _
                           NULL )
 
    ' no son necesarios si se ha empleado el metodo "WS_VISIBLE" al crear la ventana, pero no viene mal usarlo
    ShowWindow( hWnd_Main, iCmdShow )
    UpdateWindow( hWnd_Main )  


   ' -------------------- AQUI INICIAMOS IRRLICHT ----------------------------------
	' creamos una escena animada
	Dim Camera As Integer
	
	' add a bright ambient light To the scene To brighten everything up
	iAmbientLight( 1,1,1 )

	' add a static camera To the scene To observe the animation
	Camera = iCreateCamera( IRR_NO_PARENT )
	iCameraTarget( Camera, 0, 0, 0 )
	
	' asocia la camara al movimiento circular
	Dim As Integer anim = iFlyCircleAnimator(Camera, 0.0,15.0,0.0,30.0,.001)


    ' Create the box
    Dim AnimatedBox As Integer
    AnimatedBox = iCreateCube( 20, IRR_NO_PARENT )
    iPositionNode( AnimatedBox, 0, 0, 0 )
    ' texture the box
    iNodeTexture ( AnimatedBox, iLoadTexture( "./media/water.jpg" ), 1 )
    iNodeTexture ( AnimatedBox, iLoadTexture( "./media/wall.bmp"  ), 0 )
	 iNodeMaterialFlag( AnimatedBox , IRR_EMF_LIGHTING ,FALSE )
	 iNodeMaterialType( AnimatedBox , IRR_EMT_REFLECTION_2_LAYER) 

	'  the skybox is a simple hollow cube that surrounds the whole scene. textures
	'  are applied to all of the six sides of the cube creating an image around the
	'  entire scene instead of simply the color of the blank canvas
	'  here we load the textures as parameters of the skybox command (they could
	'  of course be loaded seperatly and assigned to irr_texture variables
	Dim As Integer SKY_Front = iLoadTexture("./media/irrlicht2_ft.jpg")
	Dim As Integer SKY_Back = iLoadTexture("./media/irrlicht2_bk.jpg")
	Dim As Integer SKY_Left = iLoadTexture("./media/irrlicht2_lf.jpg")
	Dim As Integer SKY_Right = iLoadTexture("./media/irrlicht2_rt.jpg")
	Dim As Integer SKY_Up = iLoadTexture("./media/irrlicht2_up.jpg")
	Dim As Integer SKY_Down = iLoadTexture("./media/irrlicht2_dn.jpg")
	Dim As Integer SkyBox = iCreateSkybox(SKY_Up,SKY_Down,SKY_Right,SKY_Left,SKY_Front,SKY_Back)
	   
	   
	   
	   
	 ' --------------------------------------------------------  
	 ' Process windows messages  
	 dim hAccelTable as HACCEL 
	 hAccelTable = LoadAccelerators( hInstGlobal, NULL )
    Dim wMsg as MSG
    While TRUE ' infinito
    	If PeekMessage(@wMsg, NULL, 0, 0, PM_REMOVE) then
			If( TranslateAccelerator( wMsg.hwnd, hAccelTable, @wMsg ) = 0 ) then
	        	TranslateMessage( @wMsg )
	        	DispatchMessage( @wMsg )
	        	'if (wMsg.message = WM_QUIT) Then iEndIrr3D() ' aqui no tiene sentido
			End If
		End If
		' procesa la ventana grafica IRRLICH
		iRun()
   	iBeginScene()
   	iDrawScene()
   	'iDrawGui() ' opcional
   	iEndScene()
    wend

    ' Program has ended
    function = wMsg.wParam

end function






