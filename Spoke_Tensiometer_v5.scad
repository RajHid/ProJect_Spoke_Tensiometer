// * Discription what the *.scad is about ect.
/*

A mesuring device to measure the tension of bicicle weel spokes by deflecting the spoke wiht a defined force (spring) applied on a certan distance (like a bridge) and measure the deflection wiht a dial gauge

*/
// ==================================
// = Used External Modules =
// ==================================

use<Dial_Gauge_v4.scad>;

//translate([10,10,10]){
//    include<Dial_Gauge_v4.scad>;
//}

DDialHousing=53.5;    //Diameter Dial Housing
DDialHousingScrweRingDiff=3;

// Difference the Backplate Screws have in relation to the Housing
ScrewRingDiameter=DDialHousing-2*DDialHousingScrweRingDiff;

// ==================================
// = Used Libraries =
// ==================================

// 


// ==================================
// = Variables =
// ==================================


//Spoke_Inputvallues
// +++++++++++++++++++++++++++
//// Level 0
// +++++++++++++++++++++++++++
EdgeRound=6; // For minkowski operation, applied as an radius
//BasePlateThickness_Input=5;
BasePlateThickness=5;

// Distance the Spoke gets supportet under load (like a bridge)
SpokeSupportDistance=120;
Spoke_d=1.8;
ProbeValue_SpkTens=3.47; //2.23 or any between 0 and 10.0mm

// lenght of the Dail Gauge over all
GaugeLength=110;
Spoke_l=200;

// Applies the deviation Load on the Spoke
SpringLength=30;

// Bio Parameters
// Diameter of fingers
FingerHoleDiameter=32;
// Distance between fingers
FingerHoleDistance=60;

// Distance of the raeach of the fingers to grap in the holes whenn the Palmblock rests against the palm
FingerPalmDistance_Input=80;
FingerHolePos_x=0;
FingerHolePos_y=-GaugeLength/4;
FingerHolePos_z=0;

// Inner diameter of bearing
Bearing_d=3;
// Outer diameter
Bearing_D=10;
Bearing_h=4;

WasherBearingThickness=0.5;
WasherBearing_D=7;

BeaingBackplateHole_D=4;

//// The Cutouts for the holes
SliderCutLenght=12;

// SpokeLoadingSlider
// the Sliding Part that applies the Load on the Spoke via the LoadBlock
SpokeLoadingSlider_x=20;
SpokeLoadingSlider_y=200;
SpokeLoadingSlider_z=5;

LoadBlock_x=SpokeLoadingSlider_x;
LoadBlock_y=10;
LoadBlock_z=5;


// +++++++++++++++++++++++++++
//// Level 1
// +++++++++++++++++++++++++++

// Distance of the Mountholes from The Edge of the Backplate
BearingMountHoleEdge_Input_x=6;
BearingMountHoleEdge_Input_y=6;

// +++++++++++++++++++++++++++
// Level 2
// +++++++++++++++++++++++++++

BasePlateWidht=SpokeSupportDistance+2*BearingMountHoleEdge_Input_x-2*EdgeRound;                 // Subtractes the added radus for minkowski operation beforhand to stay in measurments
BasePlateHeight=GaugeLength+SpringLength+(GaugeLength/2-FingerPalmDistance_Input)-2*EdgeRound;
echo("BasePlateHeight",BasePlateHeight);

// Distance from center to center aka the distance the Spoke is supported
BearingDistance=SpokeSupportDistance;

//BearingMountHole_x=BasePlateWidht_Input-2*BearingMountHoleEdge_Input_x;
BearingMountHole_y=BasePlateHeight+FingerPalmDistance_Input-BearingMountHoleEdge_Input_y;

// +++++++++++++++++++++++++++
// Level 3
// +++++++++++++++++++++++++++

SpokeSupportCenterline_x=0; // should be on centerline
SpokeSupportCenterline_y=-BasePlateHeight/2-Spoke_d/2-Bearing_D/2;
SpokeSupportCenterline_z=BasePlateThickness+WasherBearingThickness+Bearing_h/2;

// SpokeLoadingSlider


// Composed parameters
// for parameters taht are composed of several other parameters and apply for several other modules

// the contact point of the Spoke and the tip of the dial gauge
Contact_Point_Displacement=10;

Contakt_SpokeLine_x=0;
Contact_SpokeLine_y=-BasePlateHeight/2-Bearing_D/2+ProbeValue_SpkTens+Contact_Point_Displacement;
Contact_SpokeLine_z=BasePlateThickness+WasherBearingThickness+Bearing_h/2+10;

// Dial Gauge Scews to mount the Dial Gauge to the Backplate
DialGaugeBackplateScrew_D=1.0;
DialGaugeBackplateScrew_RotDiff=0;
DialGaugeBackplateScrew_YDiff=Contact_SpokeLine_y+42+DDialHousing/2-ProbeValue_SpkTens;

// The Dumpster
//BearingMountBaseLine=0;
//SpokeBaseLine_y=0;

//BasePlateWidht_Input=100;   //120
//BasePlateHeight_Input=175;  //100


// ==================================
// = Tuning Variables =
// ==================================
// Variables for finetuning (The Slegehammer if something has to be made fit)

// ==================================
// = Test Stage =
// ==================================


module MirrorMirrorOnTheWall(Offset){
    translate([0,Offset,0]){
        children();
        mirror([1,0,0]){
            children();
        }
    }
    translate([0,-Offset,0]){
        mirror([0,1,0]){
            children();
            mirror([1,0,0]){
                children();
            }
        }
    }
}

module POSITROTPOSIT(VeKtOr){
    if(     VeKtOr[9]   !=1 && VeKtOr[9]  !=0 ||
            VeKtOr[10]  !=1 && VeKtOr[10] !=0 || 
            VeKtOr[11]  !=1 && VeKtOr[11] !=0     ){
        ErRoR_MeSsAgE("POSITROTPOSIT");
        // Var must be 1 or 0 !!!
    }
    else if (true){
        mirror([0,0,0]){
            translate([VeKtOr[0],VeKtOr[1],VeKtOr[2]]){
                rotate([VeKtOr[3],VeKtOr[4],VeKtOr[5]]){
                    translate([VeKtOr[6],VeKtOr[7],VeKtOr[8]]){
                        children();
                        //circle(25,$fn=4);
                    }
                }
            }
        }
        if (   VeKtOr[9]==1 || VeKtOr[10]==1 || VeKtOr[11]==1){
            mirror([    VeKtOr[9],VeKtOr[10],VeKtOr[11]]){
                translate([VeKtOr[0],VeKtOr[1],VeKtOr[2]]){
                    rotate([VeKtOr[3],VeKtOr[4],VeKtOr[5]]){
                        translate([VeKtOr[6],VeKtOr[7],VeKtOr[8]]){
                            children();
                            //circle(19,$fn=4);
                        }
                    }
                }
            }
        }
    }
}
// Error message for using if statements to give a clue by wich module the problem is caused
module ErRoR_MeSsAgE(FooBaa){
    linear_extrude(height=100,center= true){
        text(text=str("Error_in_module()_",FooBaa), size= 5, font = "Liberation Sans:style=Bold Italic");
    }
}
// === Facettes Numbers ===


FN_HexNut=6;


FN_Performance=36;

// Divisebile by 4 to align Cylinders whithout small intersections
FN_Rough=12;
FN_Medium=36;
FN_Fine=72;
FN_ExtraFine=144;


//// For Testing and Development, makes Colorfull objekts
see_me_half(){
    translate([0,0,0]){
        linear_extrude(BasePlateThickness){
            Base_Plate();
        }
    }
    translate([0,0,BasePlateThickness]){
        linear_extrude(BasePlateThickness){
            Base_Plate_Upper();   
        }
    }
    translate([0,0,-BasePlateThickness]){
        linear_extrude(BasePlateThickness){
            Base_Plate_Lower();   
        }
    }
    translate([0,0,0]){
//POSITROTPOSIT(  [   BearingDistance/2,-BasePlateHeight/2,BasePlateThickness+WasherBearingThickness,
//                            0,0,0,
//                            0,0,0,
//                            1,0,0   ]){
        POSITROTPOSIT(  [   BearingDistance/2,
                            Contact_SpokeLine_y+Bearing_D/2-ProbeValue_SpkTens, //-Bearing_D/2+ProbeValue_SpkTens // ProbeValue_SpkTens
                            Contact_SpokeLine_z-Bearing_h/2,
                            0,0,0,
                            0,0,0,
                            1,0,0   ]){
            Support_Bearings();
        }
    }
    translate([0,0,0]){
        
    }
    translate([0,0,0]){
        Linear_Extruding(SpokeLoadingSlider_z,-1){
            Slider_Plate();
        }
    }
    translate([0,0,0]){
        
    }
    translate([0,0,0]){
        POSITROTPOSIT(  [   SpokeSupportCenterline_x,
                            Contact_SpokeLine_y-Spoke_d-LoadBlock_y,
                            Contact_SpokeLine_z-LoadBlock_z/2,
                            0,0,0,
                            0,0,0,
                            0,0,0   ]){
            Linear_Extruding(LoadBlock_z,0){
                Load_Block();
            }
        }
    }
    translate([0,0,0]){
        //TheSpoke();
    }
    translate([0,0,0]){
        POSITROTPOSIT(  [   SpokeSupportCenterline_x,
                            Contact_SpokeLine_y-Spoke_d/2-ProbeValue_SpkTens,
                            Contact_SpokeLine_z,
                            0,0,0,
                            0,0,0,
                            1,0,0   ]){
            TheSpock();
        }
    }
    union(){

    }//-BasePlateHeight/2-Spoke_d/2-Bearing_D/2
    POSITROTPOSIT(  [   0,Contact_SpokeLine_y,Contact_SpokeLine_z,
                        90,0,180,
                        0,0,0,
                        0,0,0   ]){
                        //cube(10);
                        Dial_Gauge_v4_All(ProbeValue_SpkTens);
    }
}   
module see_me_half(){
    //difference(){
        //union(){
          translate([0,0,0]){
            for(i=[0:1:$children-1]){
                a=255;
                b=50;
                k_farbabstand=((a-b)/$children);
                //Farbe=((k_farbabstand*i)/255);
                SINUS_Foo=0.5+(sin(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                COSIN_Foo=0.5+(cos(((360/(a-b))*k_farbabstand)*(i+1)))/2;
                color(c = [ SINUS_Foo,
                            1-(SINUS_Foo/2+COSIN_Foo/2),
                            COSIN_Foo],
                            alpha = 0.5){  
                    //MirrorMirrorOnTheWall(0){
                    difference(){
                        //MirrorMirrorOnTheWall(0){
                            render(convexity=20){children(i);}
                            //children(i);
                        //}
// Creates a Cutting to see a Sidesection cut of the objects
                            color(c = [ SINUS_Foo,
                                1-(SINUS_Foo/2+COSIN_Foo/2),
                                COSIN_Foo],
                                alpha = 0.2){
                                translate([0,0,0]){
                                    //cube([10,10,150],center=true);
                                }
                                translate([0,0,0]){
                                    //cube([30,30,150],center=false);
                                    }
                                }
                            }
                        }
                    }
                }
            }

// == Testprints ==

Projection_Cutter(0){
}

//// == Cutes a slice of the Objekts
Intersection_Test_Cut("yz",1,0){
// Intersection_Test_Cut("Plaine xy yz xz", Slicethickness , Distance from coordinate origin in plaine )
   // OBJECTMODULESHERE 
}

// ==================================
// = Modus =
// ==================================

 
// ==================================
// = Stage =
// ==================================
// Final module for Produktion


// ===============================================================================
// =--------------------------------- Enviroment Modules ------------------------=
// ===============================================================================
// Modules that resembles the Enviroment aka the helmet where to atach a camera mount

// Tee Spoke to be measured
//TheSpoke ();
module TheSpoke (){
    POSITROTPOSIT(  [       SpokeSupportCenterline_x,
                            SpokeSupportCenterline_y,
                            SpokeSupportCenterline_z,
                            0,90,0,
                            0,0,0,
                            1,0,0   ]){
    cylinder(h=Spoke_l,d=Spoke_d,$fn=8);
    }
}

supp_l=SpokeSupportDistance;
a=360/supp_l;
spke_d=1.8;
steps=1;
deflect=ProbeValue_SpkTens;
// ProbeValue_SpkTens
//TheSpock();
module TheSpock(){
    for (i=[0:steps:supp_l/2]){
        translate([0,deflect/2,0]){
            hull(){
                rotate([0,0,0]){
                translate([i,cos(i*a)*deflect/2,0]){
                    echo(i);
                        //Spoke_Segment_Hull();
                        rotate([0,90,0]){
                            cylinder(h=steps,d=spke_d,$fn=4,center=true);
                        }
                    }
                }
            }
        }
    }
}
//Spoke_Segment_Hull();
module Spoke_Segment_Hull(){        
    rotate([0,90,0]){
        linear_extrude(height=steps/4,scale=0.2){
            circle(d=spke_d,$fn=8);
        }
    }    
    translate([steps,0,0]){
        rotate([0,90,0]){
            linear_extrude(height=steps/4,scale=0.2){
                circle(d=spke_d,$fn=8);
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- Modules -----------------------------------=
// ===============================================================================

//Support_Bearings();
module Support_Bearings(){
    difference(){
        union(){
            translate([0,0,Bearing_h]){
                cylinder(h=WasherBearingThickness,d=WasherBearing_D,center=false);
            }
            cylinder(h=Bearing_h,d=Bearing_D,center=false);
            translate([0,0,0]){
                cylinder(h=WasherBearingThickness,d=WasherBearing_D,center=false);
            }
            translate([0,0,-WasherBearingThickness]){
                cylinder(h=WasherBearingThickness,d=WasherBearing_D,center=false);
            }
        }
        //Bearing Screw
        translate([0,0,-Bearing_h/2]){
            cylinder(h=2*Bearing_h,d=Bearing_d,center=false);
        }
    }
}

// ===============================================================================
// ---------------------------------- Cutting Modules ----------------------------
// ===============================================================================
// === Half Cutter
//Bacplate_Hole_Cutter();
module Backplate_Hole_Cutter(){
    POSITROTPOSIT(  [   FingerHoleDistance/2,0,0,
                            0,0,0,
                            0,FingerHolePos_y,0,
                            1,0,0   ]){
        Finger_Holes(FingerHoleDiameter);
    }
    // Bearing Position
    POSITROTPOSIT(  [   BearingDistance/2,Contact_SpokeLine_y,0,
                        0,0,0,
                        0,0,0,
                        1,0,0   ]){
        circle(d=BeaingBackplateHole_D);
    }        
    Dial_Gauge_Backplate_Holes();
    //Slider_Cut();
    POSITROTPOSIT(  [   0,0,0,
                        0,0,0,
                        0,0,0,  
                        0,1,0   ]){
        // Cuts the edges of the base plate                
        translate([0,60,0]){
            Slider_Cut(10,SliderCutLenght);
        }
    }
}


//Bolt(25,3,8,3);
module Bolt(BOLTLENGTH,BOLTDIAMETER,HEADDIAMETER,HEADHEIGHT){
    cylinder(h=BOLTLENGTH,d=BOLTDIAMETER,center=false,$fn=FN_Performance);
    translate([0,0,-HEADHEIGHT/2]){
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
        cylinder(h=HEADHEIGHT,d=HEADDIAMETER,center=true,$fn=6);
    }
}

module Projection_Cutter(Offset_z){    
    projection(cut = true){
        translate([0,0,Offset_z]){
            children();
        }
    }
}
// ===============================================================================
// ---------------------------------- Intersection Modules -----------------------
// ===============================================================================
module Intersection_Test_Cut(PLAIN,THICKNESS,OFFSET){
// ==== EXAMPLE ====
//    !Intersection_Test_Cut("xy",1,7/2){sphere(7);};
// ==== EXAMPLE ====
    if (PLAIN=="xz"){
        intersection(){
            children();
            translate([0,OFFSET,0]){
                cube([100,THICKNESS,100],center=true);
            }
        }
    }
    else if (PLAIN=="xy") {
        intersection(){
            children();
            translate([0,0,OFFSET]){
                cube([100,100,THICKNESS],center=true);
            }
        }
    }
    else if (PLAIN=="yz") {
        intersection(){
            children();
            translate([OFFSET,0,0]){
                cube([THICKNESS,100,100],center=true);
            }
        }   
    }
}
// ===============================================================================
// ---------------------------------- Linear Extrude Modules ---------------------
// ===============================================================================

module Ring_Shaper(HEIGHT,OUTER,WALLTHICKNESS){
    linear_extrude(HEIGHT,scale=1.00){
        2D_Ring_Shape(OUTER,OUTER-2*WALLTHICKNESS);
    }
}

module Linear_Extruding(ExtrudeLength,ExrtudingDirektionInverter){
    Length=ExtrudeLength;
    translate([0,0,Length*ExrtudingDirektionInverter]){
        linear_extrude(height=ExtrudeLength){
            children();
        }
    }
}
// ===============================================================================
// ---------------------------------- Rotate Extrude Modules ---------------------
// ===============================================================================
//DONUT(1,20,1,7);
module DONUT(DIAMETER,DIAMETER_RING,SCAL_X,SCAL_Y){
//DIAMETER The dough part
//DIAMETER_RING The hole part
//SCAL_X, skales the x dimension
//SCAL_Y, skales the y dimension
    rotate_extrude(angle=360,convexity=3,$fn=FN_Fine){
        translate([DIAMETER_RING,0,0]){
            scale([SCAL_X,SCAL_Y,1]){
                circle(d=DIAMETER,$fn=FN_Fine);
            }
        }
    }
}
// ===============================================================================
// =--------------------------------- 2D-Shapes ---------------------------------=
// ===============================================================================

//2D_Ring_Shape(15,10);
module 2D_Ring_Shape(OUTER_D,Inner_D){
    difference(){
        circle(d=OUTER_D,$fn=FN_Fine);
        circle(d=Inner_D,$fn=FN_Fine);
    }
}
//2D_Rounded_Square_Base_Shape(10,20,3);
module 2D_Rounded_Square_Base_Shape(DIMENSION_X,DIMENSION_Y,RADIUS){
    translate([RADIUS,RADIUS,0]){
        minkowski(){
            square([DIMENSION_X-RADIUS*2,DIMENSION_Y-RADIUS*2]);
            circle(r=RADIUS,$fn=FN_Fine);
        }
    }
}
//Base_Plate_Upper();
module Base_Plate_Upper(){
    difference(){
        Base_Plate();
        POSITROTPOSIT(  [   0,DialGaugeBackplateScrew_YDiff,0,
                            0,0,0,
                            0,0,0,
                            0,0,0   ]){
            circle(d=DDialHousing);
        }
        //square([10,90],center=true);
    }
}
//Base_Plate();
module Base_Plate(){
    difference(){
        union(){
            minkowski(){
                Base_Plate_Shape();
                circle(r=EdgeRound);
            }   
        }
        Backplate_Hole_Cutter();
    }
}
//Base_Plate_Upper();
module Base_Plate_Lower(){
    difference(){
        Base_Plate();
        POSITROTPOSIT(  [   0,DialGaugeBackplateScrew_YDiff,0,
                            0,0,0,
                            0,0,0,
                            0,0,0   ]){
            //circle(d=DDialHousing);
        }
        square([20,120],center=true);
    }
}
module Base_Plate_Shape(){
    difference(){
        // The Base Square for the thing
        square([BasePlateWidht, BasePlateHeight],center=true);
        POSITROTPOSIT(  [   BasePlateWidht/2+BasePlateWidht/5,
                            BasePlateHeight/2,
                            0,
                            0,0,35,
                            0,0,0,  
                            1,0,0   ]){
            // Cuts the edges of the base plate                
            square([BasePlateWidht,BasePlateHeight],center=true);
        }
    }
}
//Slider_Plate();
module Slider_Plate(){
    square([SpokeLoadingSlider_x,SpokeLoadingSlider_y],center=true);
}
//Slider_Cut();
SliderCutWidht=10;
module Slider_Cut(SliderCutWidht,SliderCutLenght){
    Smooth(3){
        Slider_Bar();
        //square([SliderCutWidht,SliderCutLenght],center=true);
    }
}
//Finger_Holes();
module Finger_Holes(FingerHoleDiameter=10){
    circle(d=FingerHoleDiameter);
}


//Dial_Gauge_Backplate_Holes();
DegreeBackplate_Diff=20;
module Dial_Gauge_Backplate_Holes(){
    for(i=[DialGaugeBackplateScrew_RotDiff:120:360+DialGaugeBackplateScrew_RotDiff]){
        POSITROTPOSIT(  [   0,DialGaugeBackplateScrew_YDiff,0,
                            0,0,i-DegreeBackplate_Diff,
                            ScrewRingDiameter/2,0,0,
                            0,0,0   ]){
            circle(DialGaugeBackplateScrew_D);            
        }
    }
}
// === Load_Block ===
// Peace that make the contact to the Spoke to aply the deviation force
//Load_Block();
module Load_Block(){
    Smooth(3){
        hull(){
            square([LoadBlock_x,LoadBlock_y],center=true);
            difference(){
                circle(r=LoadBlock_y);
                translate([0,-LoadBlock_x/2,0]){
                    square([LoadBlock_x,LoadBlock_x],center=true);
                }
            }
        }
    }
}
// === Slider_Bar() ===

Slider_Bar();
module Slider_Bar(){
    Smooth(3){
        square([SliderCutWidht,SliderCutLenght],center=true);
    }
}
// ===============================================================================
// =--------------------------------- Textembossing -----------------------------=
// ===============================================================================


// ===============================================================================
// =--------------------------------- Smoothing ---------------------------------=
// ===============================================================================

2D_Smooth_r=1;
// Radius of a outer Tip Rounding 
2D_Fillet_r=1;
// Radius of a inner corner Ronding
2D_Chamfer_DELTA_INN=1;
2D_Chamfer_DELTA_OUT=2;

// a straigt line on edges and corners
2D_Chamfer_BOOLEAN=false;

module Smooth(r=3){
    //$fn=30;
    offset(r=r,$fn=30){
        offset(r=-r,$fn=30){
        children();
        }
    }
}
module Fillet(r=3){
    //$fn=30;
    offset(r=-r,$fn=30){
        offset(r=r,$fn=30){
            children();
        }
    }
}
module Chamfer_OUTWARD(DELTA_OUT=3){
    //$fn=30;
    offset(delta=DELTA_OUT,chamfer=true,$fn=30){
        offset(delta=-DELTA_OUT,chamfer=true, $fn=30){
            children();
        }
    }
}
module Chamfer_INWARD(DELTA_INN=3){
    //$fn=30;
    offset(delta=-DELTA_INN,chamfer=true,$fn=30){
        offset(delta=DELTA_INN,chamfer=true, $fn=30){
            children();
        }
    }
}

// ===============================================================================
// =--------------------------------- Ruthex --------------------------------=
// ===============================================================================
// Dimensions for Ruthex Tread inseerts

//RUTHEX_M3();
module RUTHEX_M3(){    
L=5.7+5.7*0.25; // Length + Margin
echo("RUTHEX",L);
D1=4.0;    
    translate([0,0,0]){
        rotate([0,0,0]){
            translate([0,0,0]){
                cylinder(h=L,d1=D1,d2=D1,$fn=FN_Performance);
            }
        }
    }
}

// ===============================================================================
// =--------------------------------- Import STL --------------------------------=
// ===============================================================================

module NAME_OF_IMPORT(){
    rotate([0,0,-90]){
        translate([-515,-100,-45]){
            import("PATH/TO/FILE.stl",convexity=3);
        }
    }
}