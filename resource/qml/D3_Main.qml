import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15
import QtQml 2.15

Entity {
    id: sceneRoot
    property vector3d cameraUp: Qt.vector3d(0, 1, 0)
    property vector3d cameraPosition_free: Qt.vector3d(17, 4.20694, -17)
    property vector3d cameraViewCenter_free: Qt.vector3d(0, 2, -3)
    property int orbitMarker_id: 0
    property alias activ_cam: fwdrender.camera

    components: [render]

    signal camerPositionChanged(int x, int y ,int z)


//  sceneRoot Description
    RenderSettings {
        id: render
        activeFrameGraph: ForwardRenderer {
            id: fwdrender
            clearColor: "#010100"
            camera: camera_free
        }
        pickingSettings.pickMethod: PickingSettings.TrianglePicking
    }


    Camera {
        id: camera_free
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        nearPlane : 0.01
        farPlane : 100

        position: cameraPosition_free
        upVector: cameraUp
        viewCenter: cameraViewCenter_free

        onPositionChanged: {
            ///camerPositionChanged(camera_free.position.x, camera_free.position.y, camera_free.position.z);
        }
    }

    InputSettings {}

    FirstPersonCameraController {
        id: camera_free_controller
        camera: camera_free
    }

    Component.onCompleted : {
        cameraChanged.connect(activate_free_camera)
    }


/*!
    The general (x,y,z) - Vector is rotated to a (x,z,-y) Vector becouse the FirstPersonCameraController cant handle the z-axis as
    up axis.
    1 km equals 0.001 point in 3D. This decision is made, to avoid to big floating point errors.

*/

    D3_Sun {}

    D3_Earth {}

    D3_Plane {
        enabled: grid_enabled
    }

    Connections{
        target: Controller
        function onSpacecraftUpdated() {
            orbitMarker_id = 0
        }
    }

    function activate_free_camera(cam_id) {
        if(cam_id === 0) {
            camera_free.position = cameraPosition_free
            camera_free.viewCenter = cameraViewCenter_free
            camera_free.enabled = true
            camera_free_controller.enabled = true
            activ_cam = camera_free
            consume_lclick = false
        }
        else {
            camera_free.enabled = false
            camera_free_controller.enabled = false
        }
    }

}



