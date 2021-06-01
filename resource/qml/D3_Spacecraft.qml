import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15
import QtQml 2.15


Entity {
    property vector3d sat_camera_def_pos: Qt.vector3d(-4, 0, 0)
    property vector3d sat_camera_def_up: Qt.vector3d(0, 1, 0)

    Transform{
        id: transform
    }

    Connections {
        target: Controller
        function onSpacecraftUpdated() {
            calculatePosition();
            calculateRotation();
        }
     }

    function calculatePosition(){
        var data = Controller.getSpacecraftData()

        //console.log("x" + data[1])
        //console.log("y" + data[2])
        //console.log("z" + data[3])

        var x = data[1] / 1000;
        var y = data[2] / 1000;
        var z = data[3] / 1000;
        transform.translation = Qt.vector3d(x,z,-y);

        var x_quat = data[4];
        var y_quat = data[5];
        var z_quat = data[6];
        var scalar = data[7];
        transform_cords_sat.rotation = Qt.quaternion(scalar,x_quat,z_quat,-y_quat);

    }

    function calculateRotation(){
        var data = Controller.getLVLHquaternion()
        var x = data[0];
        var y = data[1];
        var z = data[2];
        var scalar = data[3];

        //transform.rotation = Qt.quaternion(scalar,x,z,-y);
    }


    components: [lvlh, cameraspace, cameraspace_controller, transform]

    D3_ShortCoordinationSystem {
        id: lvlh
        scale: Qt.vector3d(0.15,0.15,0.15)
        offcenter: 0.1


        Camera {
            id: cameraspace
            projectionType: CameraLens.PerspectiveProjection
            fieldOfView: 45
            nearPlane : 0.01
            farPlane : 100
            aspectRatio: camera_free.aspectRatio
            enabled: true

            viewCenter: Qt.vector3d(0, 0, 0)
            position: sat_camera_def_pos
            //upVector: sat_camera_def_up

            onPositionChanged: {
                cameraspace.viewCenter = Qt.vector3d(0, 0, 0)
                //camerPositionChanged(cameraspace.position.x/10 + sc.position.x , cameraspace.position.y/10 + sc.position.y , cameraspace.position.z/10 + sc.position.z);
            }
        }

        OrbitCameraController {
            id: cameraspace_controller
            camera: cameraspace
            linearSpeed: 10
            zoomInLimit: 0.1
        }


        function activate_spacecraft_camera(cam_id) {
            if(cam_id === 2) {
                cameraspace.upVector = sat_camera_def_up
                cameraspace.position = sat_camera_def_pos
                cameraspace.viewCenter = Qt.vector3d(0, 0, 0)
                cameraspace.enabled = true
                cameraspace_controller.enabled = true
                activ_cam = cameraspace
                consume_lclick = true
            }
            else {
                cameraspace.enabled = false
                cameraspace_controller.enabled = false
            }
        }

        Component.onCompleted : {
            cameraChanged.connect(activate_spacecraft_camera)
        }


        components: [cords_sat]

        D3_CoordinationSystem {
            id: cords_sat
            scale: Qt.vector3d(0.05,0.05,0.1875)

            components: [sc, transform_cords_sat]

            Transform {
                id: transform_cords_sat
            }


                Entity {
                id: sc
                property double earthRadius: 6.378
                property alias scale: transform.scale
                property alias position: transform.translation

                components: [mesh, diffuseMaterial, transform_sc]

                Mesh {
                    id: mesh
                    source: "qrc:/resource/objects/LitSat-1.obj"
                }

                DiffuseSpecularMaterial {
                    id: diffuseMaterial
                    diffuse: "orange"
            //        specular: "orange"
            //        ambient: "orange"
                }

                Transform {
                    id: transform_sc
            //        scale: 0.001
                    scale: 0.05
                }


                Component.onCompleted : {
                    camerPositionChanged.connect(changeSize)
                }

                function changeSize(x, y, z) {

            //        console.log("x ++ y ")
            //        console.log(x + " " + y + " " + y )
            //        console.log(position.x + " " + position.y + " " + position.y )
            //        console.log(transform.matrix * Qt.vector3d(x,y,z))

                    var dx = position.x - x
                    var dy = position.y - y
                    var dz = position.z - z

                    var distance = Math.sqrt( dx*dx + dy * dy + dz * dz)

                    if(distance > 0.001) {
                        scale = distance/200
                    }

                    if(distance > 10) {
                        scale = 0.05
                    }
                }

            }
        }
    }
}
