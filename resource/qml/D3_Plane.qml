import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15
import QtQuick3D.Materials 1.15


Entity {
    id: clouds
    property Material material

    CuboidMesh {
        id: mesh
    }

//    SphereMesh {
//        radius: (6.378 * 1.015)
//        id: mesh
//    }


    Transform {
        id: transform
        scale3D: Qt.vector3d(100,0.01,100)
        //scale3D: Qt.vector3d(2,2,2)
     }

    NormalDiffuseMapAlphaMaterial  {
        id: material
        //ambient: Qt.rgba(255, 255, 255)
        diffuse: TextureLoader {
                     mirrored: false
                     source: "qrc:/resource/images/grid.png";
                     minificationFilter: Texture.LinearMipMapLinear
                     magnificationFilter: Texture.LinearMipMapLinear
                     maximumAnisotropy: 16
        }
        normal: TextureLoader {
                     mirrored: false
                     source: "qrc:/resource/images/grid_normal.png";
                     minificationFilter: Texture.LinearMipMapLinear
                     magnificationFilter: Texture.LinearMipMapLinear
                     maximumAnisotropy: 16
        }
        textureScale: 64
        shininess: 0
    }

    components: [ transform, mesh, material ]
}
