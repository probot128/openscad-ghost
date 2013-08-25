// --------------------------------------------------
//   a full scaleable ghost                              
//   with different moods: happy, sad, upset                                                                //
//   author:   probot128                                  
//   mailto:   km@ulthryvasse.de                     
//   date:     2012-07-23
//   file:     ghost-variations.scad
//   version:  1.0
//
//   function: just call the module ghost(...)
//             and a ghost appears, with
//             changing of the parameterset
//             you can change the apearance
//             of the ghost, for parameterset
//             look at the example
// --------------------------------------------------

module head(headradius,headheight,headthickness)
{
	translate([0,0,headheight])
	difference()
	{
		difference()
		{
			sphere(r=headradius);
			sphere(r=headradius-headthickness);
		}
		translate([-headradius,-headradius,-headradius*2-2])
		cube(headradius*2+2,headradius*2+2,headradius+1);
	}
	difference()
	{
		cylinder(h=headheight, r=headradius);
		translate([0,0,-1])
		cylinder(h=headheight+2, r=headradius-headthickness);
	}
}

module eyes(eyesize, eyedistance, eyeheight,headradius)
{
	translate([eyedistance,headradius,eyeheight])
	rotate([90,0,0])
	cylinder(h=headradius, r=eyesize);
	translate([-eyedistance,headradius,eyeheight])
	rotate([90,0,0])
	cylinder(h=headradius, r=eyesize);
}

module nose(nosesize,noseheight,headradius)
{
	translate([0,headradius,noseheight])
	rotate([90,0,0])
	linear_extrude(height=headradius)
	polygon(points = [ [-nosesize, 0], [nosesize, 0], [0, 2*nosesize]]);
}

module mouth(mouthsize,mouthheight,mood,headradius)
{
	translate([0,0,mouthheight])
	rotate([270,0,0])
	if(mood==0)
	{
		cylinder(h=headradius, r=mouthsize);
	} 
	else 
	{
		if (mood==1)
		{
			difference()
			{
				cylinder(h=headradius, r=mouthsize);
				translate([-mouthsize,-2*mouthsize,0])
				cube([2*mouthsize,2*mouthsize,headradius+1]);
			}
		}
		else
		{
			if (mood==2)
			{
				difference()
				{
					cylinder(h=headradius, r=mouthsize);
					translate([-mouthsize,0,0])
					cube([2*mouthsize,2*mouthsize,headradius+1]);
				}
			}
		}
	}
}

module ghost(headradius, headheight, headthickness, eyesize, eyedistance, eyeheight, nosesize, noseheight, mouthsize, mouthheight, mood)
{
	difference()
	{
		head(headradius, headheight, headthickness);
		eyes(eyesize, eyedistance, eyeheight, headradius);
		nose(nosesize, noseheight, headradius);
		mouth(mouthsize, mouthheight, mood, headradius);
	}
}

// for better resolution minimize $fs ans $fa to the minimum of 0.01
// the time to render will extend
$fs=0.5;
$fa=0.5;

// smiling ghost
ghost(7,15,1,1.5,3.5,12,1,9,3,7,1);

// thin ghost
translate([15,0,0])
ghost(4,25,1,0.5,1,18,0.5,15,1,13,1);

//thick upset ghost
translate([32,0,0])
ghost(10,15,2,3,5,12,1,9,3,5,0);

//sad ghost
translate([50,0,0])
ghost(6,12,1,1.5,3.5,12,2,7.5,3,3,2);

// module ghost(headradius, headheight, headthickness, eyesize, 
// eyedistance, eyeheight, nosesize, noseheight, mouthsize, 
// mouthheight, mood)
//
// headradius:     thickness of the complete ghost
// headheight:     the height of the cylinder without the sphere, 
//                 for complete height add headradius
// headthickness:  the ghost is hollow, you can define the thickness 
//                 of the walls
// eyesize:        how big are the eyes
// eyedistance:    how far away from the center do you want to 
//                 position the eye
// eyeheight:      how high - measured from the bottom - 
//                 do you want to position the eyes
// nosesize:       how big is the nose
// noseheight:     how high - measured from the bottom - 
//                 do you want to position the nose
// mouthsize:      how big is the mouth
// mouthheight:    how high - measured from the bottom - 
//                 do you want to position the mouth
// mood:           0 - for saying "Ohhh"
//                 1 - for happiness
//                 2 - for sadness
