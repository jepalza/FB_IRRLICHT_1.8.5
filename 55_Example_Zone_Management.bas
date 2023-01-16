'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006-2010)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 55: Zone Management
'  This example demonstrates zone management objects, these are parent objects
'  that manage the visibility of their child objects and can be used to remove
'  numbers of objects out of the visible scene when the camera moves out of
'  visible range
'  ----------------------------------------------------------------------------

'  ////////////////////////////////////////////////////////////////////////////
'  Includes for extension libraries
#Inclib "bIrrlicht"
#Include "fb_Irrlicht.bi"


'  ////////////////////////////////////////////////////////////////////////////
'  global variables

'  irrlicht objects
Dim Billboard As Integer
Dim BillboardTexture As Integer
Dim Camera As Integer
Dim zone As Integer
Dim x As Integer
Dim z As Integer
Dim n As Integer


'  ////////////////////////////////////////////////////////////////////////////
'  -----------------------------------------------------------------------------
'  start the irrlicht interface
iIrr3D( 800, 600, 32, False )

'  send the window caption
iAppTitle( "Example 55: Zone Management" )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/BlitzLogo_Big.jpg" )

'  here we create 900 zones
For x = -15 To 15
    For z = -15 To 15
        
         '  we add in a zone management object and set the near distance to 100
         '  and the far distance to 300. the zone management object will only
         '  be visible if the zone is more than 100 units from the active camera
         '  and less than 300 units away, any child objects of this zone will be
         '  completely unprocessed.
         '  if you set your zone up in conjunction with fog you can have lots of
         '  complex objects in the scene and when the zone they were in was out of
         '  camera range the objects would be completely disabled and have no
         '  impact on the processing of the scene
         '  you could also place a large number of zone managers into another zone
         '  if your environment was sufficiently complex
         '  the near value also allows you to implement a simple level of detail
         '  LOD effect by having a low and high resoloution zones overlapping one
         '  another the high resoloution zone might display from 0 to 100 while
         '  the low resoloution zone displays from 100 to 500
        zone = iCreateZoneMgr(10,300)

         '  here we create 6 billboards for each zone, this would make nearly 4600
         '  billboards but as only a small set are displayed there is minimal
         '  effect on the speed of the display
        For n = 0 To 5
            Billboard = iCreateBillBoard( 5.0, 5.0, 0, 0, 0 )
            iNodeTexture( Billboard, BillboardTexture, 0 )
            iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, IRR_OFF )
            iPositionNode( Billboard, Rnd(50), Rnd(50), Rnd(50) )
            
             '  finally we attach the billboard to the zone as a child and the
             '  billboard is thereafter automatically managed by the zone manager
            iNodeParent( Billboard, zone )
        Next

        iPositionNode( zone, x*100, 0, z*100 )
    Next
Next

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateFPSCamera(0,100,1.0,0,0,0,0,0)


'  hide the mouse pointer
iHideMouse()

iCameraCLSColor( 128, 128, 128 )

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene
    iBeginScene()

     '  draw the scene
    iDrawScene()

     '  end drawing the scene and render it
    iEndScene()

Wend

'  -----------------------------------------------------------------------------
'  Stop the irrlicht engine and release resources
iEndIrr3D()


End
