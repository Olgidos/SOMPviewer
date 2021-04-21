import QtQuick 2.15 as QQ2
import QtQml 2.15
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15


//Space Environment
Entity {
    id: lights
    property double sunRadius: 0.2
    property int au: 149600 /// 3000

    D3_CoordinationSystem {
        scale: Qt.vector3d(0.1,0.1,0.35)
        offcenter: 0
    }


    PointLight {
        id: light
        color: Qt.rgba(255, 255, 200)
        intensity: 2 //1.5
        enabled: true
//        constantAttenuation: 1
//        linearAttenuation: 0
//        quadraticAttenuation: 0
    }

    Transform {
        id: translation
        translation: Qt.vector3d(100, 0, 0)
    }

    SphereMesh {
         id: meshSun
         radius: sunRadius
         rings: 100
         slices: 100
    }

    DiffuseSpecularMaterial {
        id: diffuseMaterial
//        diffuse: "yellow"
        specular: "#ffc505"
        ambient: "#ffc505"
    }

    components: [light, translation, meshSun, diffuseMaterial]

    Connections{
        target: Controller
        function onSpacecraftUpdated() {
            var list = Controller.getEarthEphemerides()

            var x = list[0]
            var y = list[1]
            var z = list[2]

            //J2000
//            x = -0.17566 * au
//            y = 0.96599 * au
//            z = 0* au

            //Vernal Equinox 2021
//            x = -1.003059603498145 * au
//            y = 0.0104425511782964 * au

            translation.translation.x = x
            translation.translation.y = z
            translation.translation.z = -y
        }
    }
}
