'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 103: Billboard Groups
'  This example demonstrated Billboard groups. While billboards are already
'  very efficient large numbers of them can be made even more efficient by
'  collecting them up into a single group.
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

Dim PARTICLE_COUNT As Integer = 5
Dim PARTICLE_LAYERS As Integer = 15
Dim SPACING As Single = 75.0
Dim SCALE As Single = 100.0
Dim CAMERA_SPEED As Single = 1.1


'  irrlicht objects
Dim metrics As String
Dim Billboard As Integer
Dim BillboardTexture As Integer
Dim Sun As Integer
Dim Camera As Integer
Dim particles( PARTICLE_COUNT * PARTICLE_LAYERS ) As integer


'  ////////////////////////////////////////////////////////////////////////////
'  start the irrlicht interface
iIrr3D( 1024, 768, 32, False )

'  add a skybox with a space theme to the scene as a backdrop
Dim Sky As Integer = iLoadTexture("./media/starbox1.jpg")
Dim SkyBox As Integer = iCreateSkybox( Sky,Sky,Sky,Sky,Sky,Sky)

'  Create a billboard representing the Sun
'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/sun.tga" )

'  add the billboard to the scene
Sun = iCreateBillBoard( 256.0, 256.0,  0.0, 0.0, 998.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeTexture( Sun, BillboardTexture, 0 )

'  hide transparent areas
iNodeMaterialFlag( Sun, IRR_EMF_LIGHTING, False )
iNodeMaterialType ( Sun, IRR_EMT_TRANSPARENT_ALPHA_CHANNEL )

'  Create a billboard representing the Moon
'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/moon.tga" )

'  add the billboard to the scene
Dim Moon As Integer = iCreateBillBoard( 20.0, 20.0,  0.0, 0.0, 1200.0 )

'  now we apply the loaded texture to the billboard using node material index 0
iNodeMaterialFlag( Moon, IRR_EMF_LIGHTING, False )
iNodeTexture( Moon, BillboardTexture, 0 )

'  hide transparent areas
iNodeMaterialType( Moon, IRR_EMT_TRANSPARENT_ALPHA_CHANNEL_REF )

'  make the moon orbit the sun
iFlyCircleAnimator( Moon, 0.0,0.0,1000.0, 800.0, 0.0001 )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/cloudtest.bmp" )

'  add a billboard group to the scene
Billboard = iCreateBillBoardGroup()

Dim As Integer i,j
Dim As Single x,y,z
Dim As Integer small, big
For j = 1 To PARTICLE_LAYERS 
    For i = 1 To PARTICLE_COUNT 

         '  Generate a random co-ordinate in a cube
       	x  = Rnd(1)-0.5
         y  = Rnd(1)-0.5
         z  = Rnd(1)-0.5
        
         '  normalise the co-ordinate. this scales the x,y,z so they are
         '  exactly a distance of 1 * SCALE from origin and when they are
         '  all the same distance they appear as points on a sphere
        Dim factor As Single = 1 / Sqr( x*x + y*y + z*z )
        x = x * factor * SPACING * j
        y = y * factor * SPACING * j
        z = z * factor * SPACING * j

         '  calculate a couple of color values
        small = (255 / PARTICLE_LAYERS) * j / 3
        big   = (255 / PARTICLE_LAYERS) * j

         '  the particle can be one of two colors to add some tone to the cloud
        Select Case (i Mod 2)
        	Case 0
             '  add a billboard to the group. the parameters are as follows: -
             '  The billboard group node
             '  the X,Y scale of the billboard
             '  X,Y,Z co-ordinates for the billboard
             '  a roll for the billboard that allows each billboard to be rotated
             '  A,R,G,B color values
            particles(i+(j-1)*PARTICLE_COUNT) = iBillBoardToGroup( Billboard, 15.0*SCALE - 3.0*SCALE*j, 15.0*SCALE - 3.0*SCALE*j, x,y,z, 0.0, 255, 255-big, 255, 255-small )
	      Case 1
             '  this billboard is slightly bigger and more yellow
            particles(i+(j-1)*PARTICLE_COUNT) = iBillBoardToGroup( Billboard, 20.0*SCALE - 3.0*SCALE*j, 20.0*SCALE - 3.0*SCALE*j, x,y,z, 0.0, 255, 255-small, 255, 255-big )
        End Select
    Next
Next

'  just move the particles forward so we can have a good look at them
iPositionNode( Billboard, 0.0, 0.0, 1000.0 )

'  this can be used to apply a graduated shading to billboards color
iBillBoardGroupShadows( BillBoard, 1, 0, 0, 1.0, 0.5 )

'  apply the loaded texture to the billboard group using node material index 0
iNodeTexture( Billboard, BillboardTexture, 0 )

'  disabling lighting
iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, False )

'  layer the colour upon what is already there (works well for clouds)
iNodeMaterialType( Billboard, IRR_EMT_TRANSPARENT_ADD_COLOR )

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateFPSCamera( False, 100.0, CAMERA_SPEED,-1,0,0,0,0.0 )
iCameraRange( Camera, 128000, 1.0 )

'  hide the mouse pointer
iHideMouse()

'  -----------------------------------------------------------------------------
i = PARTICLE_COUNT * PARTICLE_LAYERS

'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

         '  remove particles over time
'         If i > 0 Then
'             iFreeBillBoardFromGroup( Billboard, particles( i ))
'             i = i - 1
'         End If

         '  begin the scene
        iBeginScene()


         '  Change the title to show the frame rate
        metrics = "Example 103: Billboard groups ("+Str(iBillBoardGroupCount( Billboard ))+" clouds) ("+Str( iGetFPS() )+" fps)"
        iAppTitle( metrics )

         '  we are drawing in two passes first the sun, moon and sky
        iHideNode( Billboard )
        iShowNode( Sun )
        iShowNode( Moon )
        iShowNode( SkyBox )

         '  draw the scene
        iDrawScene()

         '  on the second pass we are just drawing the clouds. by doing this we
         '  ensure that if billboards get in front of the clouds origin but are
         '  still IN the clouds they are still covered by cloud
        iShowNode( Billboard )
        iHideNode( Sun )
        iHideNode( Moon )
        iHideNode( SkyBox )

         '  draw the scene
        iDrawScene()
    
         '  end drawing the scene and render it
        iEndScene()

Wend 

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
