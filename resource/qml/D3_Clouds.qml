import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15

Entity {
    property double earthRadius: 6.378
    property double cloudsFactor: 1.0015
    property double atmosphereFactor: 1.015


    //Clouds
    Entity {
        id: clouds
        property Material material

        SphereMesh {
            radius: (earthRadius * cloudsFactor)
            rings: 100
            slices: 100
            id: meshClouds
        }

        Transform {
            id: transformEarth
            rotationX: 180
            rotationY: 180
            rotationZ: 0
         }

        NormalDiffuseMapAlphaMaterial  {
            id: material
            diffuse: TextureLoader {
                         mirrored: false
                         source: "qrc:/resource/images/highRes/clouds16k.png";
                         minificationFilter: Texture.LinearMipMapLinear
                         magnificationFilter: Texture.LinearMipMapLinear
                         maximumAnisotropy: 16
            }
            normal: TextureLoader {
                         mirrored: false
                         source: "qrc:/resource/images/highRes/clouds_normal16k.jpg";
                         minificationFilter: Texture.LinearMipMapLinear
                         magnificationFilter: Texture.LinearMipMapLinear
                         maximumAnisotropy: 16
            }
            textureScale: 1
            shininess: 0
        }

//        components: [ meshClouds, material ]
    }



    Entity {
        id: atmosphere

        SphereMesh {
            id: meshAtmosphere
            radius: (earthRadius * atmosphereFactor)
            rings: 100
            slices: 100
        }

        PhongAlphaMaterial  {
            id: materialAtmosphere
            alpha: 0.2
            shininess: 1
            specular: "#419dd9"
            blendFunctionArg: BlendEquation.Add
            destinationAlphaArg: BlendEquationArguments.OneMinusSourceAlpha
            destinationRgbArg:  BlendEquationArguments.OneMinusSourceAlpha
            //sourceRgbArg: BlendEquationArguments.sourceAlpha
            sourceAlphaArg: BlendEquationArguments.One
            diffuse: "#419dd9"
            //ambient: "#FFFFFF"

        }
        components: [ meshAtmosphere, materialAtmosphere ]
    }

}
