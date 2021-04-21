import Qt3D.Core 2.15
import Qt3D.Render 2.15

Material {
    id: material

    parameters: [
        Parameter {
            name: "diffuseTexture"
            value: Texture2D {
                textureImages: [TextureImage {
                        source: "qrc:/resource/images/earthcloudmap.jpg"
                    }
                ]
            }
        }
    ]

    effect: Effect {
        id: rootEffect

        techniques: [
            Technique {
                graphicsApiFilter {
                    api: GraphicsApiFilter.OpenGL
                    profile: GraphicsApiFilter.CoreProfile
                    majorVersion: 3
                    minorVersion: 1
                }

                filterKeys: [ FilterKey { name: "renderingStyle"; value: "forward" } ]

                renderPasses: [
                    RenderPass {
                        shaderProgram: ShaderProgram {
                                vertexShaderCode:   loadSource("qrc:/resource/qml/shaders/cloudShader.vert")
                                fragmentShaderCode: loadSource("qrc:/resource/qml/shaders/cloudShader.frag")
                          }
                        renderStates: [
                            DepthTest {
                                depthFunction: DepthTest.LessOrEqual
                            },
                            NoDepthMask {
                            },
                            BlendEquation {
                                blendFunction: BlendEquation.Add
                            },
                            BlendEquationArguments {
                                sourceRgb: BlendEquationArguments.One
                                destinationRgb: BlendEquationArguments.OneMinusSourceAlpha
                                sourceAlpha: BlendEquationArguments.One
                                destinationAlpha: BlendEquationArguments.OneMinusSourceAlpha
                            }
                        ]
                    }
                ]
            }
        ]
    }
}
