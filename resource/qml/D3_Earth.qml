import QtQuick 2.15 as QQ2
import Qt3D.Core 2.15
import Qt3D.Render 2.15
import Qt3D.Input 2.15
import Qt3D.Logic 2.15
import Qt3D.Extras 2.15
import QtQml 2.15

Entity {
    property double earthRadius: 6.378
    property vector3d cameraPosition_earth: Qt.vector3d(23, 1, 0)
    property vector3d cameraViewCenter_earth: Qt.vector3d(0, 0, 0)
    property vector3d upVector_earth: Qt.vector3d(0, 1, 0)

    Transform {
        id: transformBase
        rotationX: 0
        rotationY: 0
        rotationZ: 0
     }

    components: [transformBase, eci]

    D3_ShortCoordinationSystem {
        id: eci
        scale: Qt.vector3d(3,3,3)
        offcenter: 5.5

        D3_Spacecraft {}

        D3_Clouds {}


        D3_CoordinationSystem {
            id: ecef
            scale: Qt.vector3d(2,2,7.5)


            Transform {
                id: transform_ecef
                rotationX: 0
                rotationY: 0
                rotationZ: 0
             }

            components: [transform_ecef]

            Camera {
                id: camera_earth
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 45
                nearPlane : 0.01
                farPlane : 100
                aspectRatio: camera_free.aspectRatio

                position: cameraPosition_earth
                upVector: upVector_earth
                viewCenter: cameraViewCenter_earth
                onPositionChanged: {
                    viewCenter = Qt.vector3d(0, 0, 0)
                }
            }

            OrbitCameraController {
                id: camera_earth_controller
                camera: camera_earth
                linearSpeed: 100
                lookSpeed: 1000
            }


            Connections {
                target: Controller
                function onSpacecraftUpdated() {
                    var data = Controller.getEarthRotationJ2000();
                    var x = data[0];
                    var y = data[1];
                    var z = data[2];
                    var scalar = data[3];

                    transform_ecef.rotation = Qt.quaternion(scalar,x,z,-y);
                }
             }


            Entity {
                id: earth

                SphereMesh {
                     id: meshEarth
                     radius: earthRadius
                     rings: 100
                     slices: 100
                }

                Transform {
                    id: transformEarth
                    rotationX: 180
                    rotationY: 180
                    rotationZ: 0
                 }

                DiffuseSpecularMaterial {
                    id: diffuseMaterialEarth
                    //ambient: TextureLoader { source: "qrc:/resource/images/earthcloudmapcolortrans.png"; }
                    diffuse: TextureLoader {
                                 mirrored: false
                                 source: "qrc:/resource/images/highRes/earth16k.jpg";
                    }
                    specular: TextureLoader {
                                 source: "qrc:/resource/images/highRes/earth_specular8k.jpg";
                                 mirrored: false
                    }
//                    normal: TextureLoader {
//                                 source: "qrc:/resource/images/highRes/earth_normal16k.jpg";
//                                 mirrored: false
//                    }
                    ambient: "#161616"
                    textureScale: 1
                    shininess: 2.5
                    alphaBlending: false
                }

                components: [ meshEarth, diffuseMaterialEarth, transformEarth  ]

                Entity {
                    property double earth_lightRadius: earthRadius + 0.001
                    id: earth_light

                    SphereMesh {
                         id: meshEarth_light
                         radius: earth_light.earth_lightRadius
                         rings: 100
                         slices: 100
                    }

                    NormalDiffuseMapAlphaMaterial  {
                        id: diffuseMaterialEarth_light
                        diffuse: TextureLoader {
                                     mirrored: false
                                     source: "qrc:/resource/images/highRes/earth_light16k.png";
                                     minificationFilter: Texture.LinearMipMapLinear
                                     magnificationFilter: Texture.LinearMipMapLinear
                                     maximumAnisotropy: 16
                        }

                        normal: TextureLoader {
                                     mirrored: false
                                     source: "qrc:/resource/images/highRes/night_lights_blank16k.png";
                                     minificationFilter: Texture.LinearMipMapLinear
                                     magnificationFilter: Texture.LinearMipMapLinear
                                     maximumAnisotropy: 16
                        }
                        ambient: "#80fbfcea"
                        textureScale: 1
                        shininess: 0
                    }

                    components: [ meshEarth_light, diffuseMaterialEarth_light ]
                }

            }
        }

        Component.onCompleted : {
            cameraChanged.connect(activate_earth_camera)
        }

        function activate_earth_camera(cam_id) {
            if(cam_id === 1) {
                camera_earth.position = cameraPosition_earth
                camera_earth.upVector = upVector_earth
                camera_earth.viewCenter = cameraViewCenter_earth
                camera_earth.enabled = true
                camera_earth_controller.enabled = true
                activ_cam = camera_earth
                consume_lclick = true

            }
            else {
                camera_earth.enabled = false
                camera_earth_controller.enabled = false
            }
        }

        Connections{
            target: Controller
            function onOrbitMarkerUpdated() {

                var x = Controller.getOrbitMarkerX()
                var y = Controller.getOrbitMarkerY()
                var z = Controller.getOrbitMarkerZ()

                while(orbitMarker_id < x.length) {

                   var min
                   var alpha = 0.2 - orbitMarker_id/Controller.getOrbitMarkerMax() * 0.2
                   var color = Qt.hsla(1,1,alpha,1)
                   //console.log(alpha)

                    var o = Qt.createQmlObject('import QtQuick 2.15 as QQ2
                                                import Qt3D.Core 2.15
                                                import Qt3D.Render 2.15
                                                import Qt3D.Input 2.15
                                                import Qt3D.Logic 2.15
                                                import Qt3D.Extras 2.15
                                                import QtQml 2.15
                                                      D3_OrbitMarker {
                                                            position: Qt.vector3d(' + x[orbitMarker_id] / 1000  + ", " + z[orbitMarker_id] / 1000  + ", " + y[orbitMarker_id] / -1000  + ')
                                                            general_color: Qt.hsla(' + alpha + ',1,0.5,1)
                                                      }'
                                                   , eci);

                    orbitMarker_id++
                }

            }
        }

    }
}
