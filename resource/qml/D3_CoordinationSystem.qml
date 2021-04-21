import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15

Entity {
    property alias scale: transform_z.scale3D
    property alias transform: transform
    property double x: 0
    property double y: 0
    property double z: 0
    property double offcenter: 0

    id: coord

    Transform {
        id: transform
        rotationX: 0
        rotationY: 0
        rotationZ: 0
     }


    Entity {
        id: z
        Mesh {
            id: mesh_z
            source: "qrc:/resource/objects/arrow.obj"
        }

        DiffuseSpecularMaterial {
            id: material_z
            ambient: "#00C914"
            specular: "#00C914"
            diffuse: "#00C914"
            shininess: 0
        }

        Transform {
            id: transform_z
            scale3D: Qt.vector3d(10, 10, 10)
            translation: Qt.vector3d(0,0 + offcenter,0 )
            rotationX: 90
        }


        components: [ mesh_z, material_z, transform_z  ]
    }

    Entity {
        id: x
        Mesh {
            id: mesh_x
            source: "qrc:/resource/objects/arrow.obj"
        }

        DiffuseSpecularMaterial {
            id: material_x
            ambient: "#2347BD"
            specular: "#2347BD"
            diffuse: "#2347BD"
            shininess: 0
        }

        Transform {
            id: transform_x
            scale3D: transform_z.scale3D
            translation: Qt.vector3d(0 + offcenter,0,0)
            rotationY: -90
        }


        components: [ mesh_x, material_x, transform_x  ]
    }


    Entity {
        id: y
        Mesh {
            id: mesh_y
            source: "qrc:/resource/objects/arrow.obj"
        }

        DiffuseSpecularMaterial {
            id: material_y
            ambient: "#B30600"
            specular: "#B30600"
            diffuse: "#B30600"
            shininess: 0
        }

        Transform {
            id: transform_y
            scale3D: transform_z.scale3D
            translation: Qt.vector3d(0,0, 0- offcenter)
        }


        components: [ mesh_y, material_y, transform_y  ]
    }

     components: [ transform, x, y, z ]
}
