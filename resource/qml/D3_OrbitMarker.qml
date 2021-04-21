import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15
import QtQml 2.15


Entity {
    id: marker

    property alias position: transform.translation
    //property alias alpha: material.alpha
    property alias scale: transform.scale
    property color general_color: "orange"

    SphereMesh {
        radius: 0.01
        id: mesh
    }


    DiffuseSpecularMaterial  {
        id: material
        ambient: general_color
        specular: general_color
        diffuse: general_color
        shininess: 0

    }

    Transform {
        id: transform
        scale: 1
        translation: Qt.vector3d(0,0,0)
        rotationX: 90
    }

    components: [ mesh, material, transform ]

    Component.onCompleted : {
        camerPositionChanged.connect(changeSize)
    }

    Connections{
        target: Controller
        function onSpacecraftUpdated() {
            camerPositionChanged.disconnect(changeSize)
            marker.destroy(0)
        }
    }

    function changeSize(x, y, z) {
        var dx = position.x - x
        var dy = position.y - y
        var dz = position.z - z

        var distance = Math.sqrt( dx*dx + dy * dy + dz * dz)

        if(distance > 0.1) {
            scale = distance/10
        }

        if(distance > 10) {
            scale = 1
        }

    }

}
