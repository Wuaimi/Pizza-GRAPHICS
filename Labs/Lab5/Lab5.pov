
// Camera
camera {
    location <0, 5, -10>
    look_at <0, 1, 0>
    angle 50
}

// Lighting
light_source { <5, 10, -5> color rgb <1, 1, 1> }
light_source { <-5, 10, -5> color rgb <1, 1, 1> }

// Table
plane {
    y, 0
    texture {
        pigment { color rgb <0.9,0.9.0.9> } //almost white
        finish { diffuse 0.8 reflection 0.1 }
    }
}

// Background
plane {
    z, 5
    texture {
        pigment { color rgb <0, 0, 0> }
    }
}

// iPad Frame
box {
    <-3.1, 0.1, -2.1>, <1.1, 0.25, 2.1> // Slightly larger than screen
    texture {
        pigment { color rgb <0.2, 0.2, 0.2> } // Dark gray frame
        finish { diffuse 0.8 }
    }
    translate <0, 0, -2> //location of the object X,Y,Z
}

// iPad Screen (Highly reflective object)
box {
    <-3, 0.12, -2>, <1, 0.2, 2> 
    texture {
        pigment { color rgb <0, 0, 0> } 
        finish {
            phong 1
            reflection 0.9 // Mirror-like reflection
            specular 0.95
        }
    }
    translate <0, 0, -2>
} 
//doesnt exist in the real picture but is here for ipad's reflection experiment
sphere {
    <0, 1, -2>, 1
    texture {
        pigment { color rgb <1, 1, 1> }
        finish { phong 1 }
    }
}

// Eyeglass case (Matte Surface Object)
superellipsoid {
    <0.6, 0.6>
    scale <2, 0.5, 1>
    translate <-1, 0.3,2> 
    texture {
        pigment { color rgb <0.2, 0.2, 0.2> }
        finish { diffuse 0.9 phong 0.1 }
    }
}

//water bottle (Transparent Object)
cylinder {
    <2, 0, 0>, <2, 3, 0>, 0.5
    texture {
        pigment { color rgbt <0.8, 0.9, 1, 0.6> }
        finish { phong 0.9 reflection 0.1 }
    }
    interior {
        ior 1.33
    }
}

// Spotlight to(simulate Windows lighting)
light_source {
    <0, 8, -5>
    color rgb <1, 1, 1>
    spotlight
    point_at <0, 1, 0>
    radius 10
}
