'  ----------------------------------------------------------------------------
'  Irrlicht Wrapper for Imperative Languages - Freebasic Examples
'  Frank Dodd (2006)
'  ----------------------------------------------------------------------------
'  Blitz-Irrlicht 1.8.3 Interface by Ed Musolino (AquaLung 2015)
'  ----------------------------------------------------------------------------
'  Example 56: Zone Management Bounding Boxes
'  This example demonstrates the display of bounding boxes created by adding
'  child objects to parent zone managment objects
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
iIrr3D( 1024, 768, 32, False )

'  send the window caption
iAppTitle( "Example 56: Zone Management Bounding Boxes" )

'  load the texture resource for the billboard
BillboardTexture = iLoadTexture( "./media/BlitzLogo_Big.jpg" )

'  add the billboard to the scene, the first two parameters are the size of the
'  billboard in this instance they match the pixel size of the bitmap to give
'  the correct aspect ratio. the last three parameters are the position of the
'  billboard object
For x = -15 To 15
    For z = -15 To 15
        zone = iCreateZoneMgr(0,600)
        iZoneMgrBndBox( zone, 0, 0, 0,  100, 100, 100 )
        iZoneMgrProperties( zone, 0, 600, 1 )
        iPositionNode( zone, x*100, 0, z*100 )
        iDebugNode( zone, &hFFFF )

        For n = 0 To 5
            Billboard = iCreateBillBoard( 5.0, 5.0, 0, 0, 0 )
            iNodeTexture( Billboard, BillboardTexture, 0 )
            iNodeMaterialFlag( Billboard, IRR_EMF_LIGHTING, False )
            iPositionNode( Billboard, Rnd(50), Rnd(50), Rnd(50) )
            iNodeParent( Billboard, zone )
        Next
    Next
Next

'  add a first person perspective camera into the scene so we can move around
'  the billboard and see how it reacts
Camera = iCreateFPSCamera(0,100.0,0.5,-1,0,0,0,0.0)

'  hide the mouse pointer
iHideMouse()

'  -----------------------------------------------------------------------------
'  while the irrlicht environment is still running
While iRun() And (Not iKeyHit( KEY_ESCAPE ))

     '  begin the scene, erasing the canvas
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
