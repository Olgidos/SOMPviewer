import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    property color text_color: "#e7e7e7"
    property color text_color2: "#ffc505"
    property int general_width: 190
    width: 300
    color: "#95232323" //AA232323
    radius: 5

    ScrollView {
        id: scrollview
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.vertical.visible: ScrollBar.vertical.size < 1
        anchors.fill: parent
        clip: true
        padding: 1
        contentWidth: 300

//        Label {
//            id: label
//            text: qsTr("Observation")
//            color: text_color
//            anchors.top: parent.top
//            anchors.left: parent.left
//            anchors.topMargin: 20
//            anchors.leftMargin: 10
//            font.bold: true
//            font.pixelSize: 14
//        }

//        Rectangle {
//            color: text_color
//            anchors.left: parent.left
//            anchors.bottom: label.bottom
//            anchors.bottomMargin: -5
//            height: 1
//            width: 150
//        }


        ColumnLayout {
            id: obsLayout
    //                anchors.top: label.bottom
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.rightMargin: 5
            anchors.leftMargin: 10
            anchors.bottomMargin: 5
            anchors.topMargin: 20
            spacing: 0


            //TRANSMISSION

            Label {
                id: labelTransmission
                text: qsTr("Transmission")
                color: text_color
                Layout.topMargin: 0
                Layout.leftMargin: 0
                Layout.bottomMargin: 15
                font.bold: true
                font.pixelSize: 14
            }


            Rectangle {
                color: text_color
                Layout.topMargin: -28
                Layout.leftMargin: -10
                height: 1
                width: 150
            }


            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Count: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_count_1.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_count_1
                    text: qsTr("0")
                    color: text_color2
                    width: 90
                    anchors.top: parent.top
                    anchors.right: lbl_count_2.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_count_2
                    text: qsTr("/")
                    color: text_color2
                    width: 10
                    anchors.top: parent.top
                    anchors.right: lbl_count_3.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_count_3
                    text: qsTr("0")
                    color: text_color2
                    width: 90
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Label {
                text: qsTr("Transmission date: ")
                color: text_color
                Layout.fillWidth: true
            }

            Label {
                id: lbl_TransmissionDate
                text: qsTr("/")
                color: text_color2
                width: general_width
                Layout.fillWidth: true
            }




            //OBSERVATION

            Label {
                id: label
                text: qsTr("Observation")
                color: text_color
                Layout.topMargin: 15
                Layout.leftMargin: 0
                Layout.bottomMargin: 15
                font.bold: true
                font.pixelSize: 14
            }


            Rectangle {
                color: text_color
                Layout.topMargin: -28
                Layout.leftMargin: -10
                height: 1
                width: 150
            }

            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Name: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_tle0.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_tle0
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Description: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_transmitter_description.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_transmitter_description
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("ID: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_id.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_id
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Obs. status: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_status.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_status
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }

            Label {
                text: qsTr("Start date: ")
                color: text_color
                Layout.fillWidth: true
            }

            Label {
                id: lbl_startDate
                text: qsTr("/")
                color: text_color2
                width: general_width
                Layout.fillWidth: true
            }


            Label {
                text: qsTr("End date: ")
                color: text_color
                Layout.fillWidth: true
                Layout.topMargin: 10
            }

            Label {
                id: lbl_endDate
                text: qsTr("/")
                color: text_color2
                width: general_width
                Layout.fillWidth: true

            }

            Label {
                text: qsTr("TLE data: ")
                color: text_color
                Layout.fillWidth: true
                Layout.topMargin: 10
            }

            Label {
                id: lbl_tle
                text: qsTr("/")
                color: text_color2
                width: general_width
                Layout.fillWidth: true
            }




            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Station name: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_station_name.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_station_name
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }



            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Station lat.: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_station_lat.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_station_lat
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }


            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Station lon.: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_station_lng.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_station_lng
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }




            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Max. altitude: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_max_altitude.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_max_altitude
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }


            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Rise azimuth: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_rise_azimuth.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_rise_azimuth
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }



            Item {
                Layout.fillWidth: true
                height: 20

                Label {
                    text: qsTr("Set azimuth: ")
                    color: text_color
                    anchors.top: parent.top
                    anchors.right: lbl_set_azimuth.left
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                }

                Label {
                    id: lbl_set_azimuth
                    text: qsTr("/")
                    color: text_color2
                    width: general_width
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }
            }





            Label {
                text: qsTr("Waterfall: ")
                color: text_color
                Layout.fillWidth: true
                Layout.topMargin: 10
            }



            Image {
                id: waterfall
                Layout.fillWidth: true
                Layout.topMargin: 5
                Layout.rightMargin: 5
//                fillMode: Image.PreserveAspectFit
//                verticalAlignment: Image.AlignTop
//                fillMode: Image.PreserveAspectCrop
//                width: 290
                smooth: true
                sourceSize.width: 290
                sourceSize.height: 400
            }

            Rectangle {
                color: "#00ffffff"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
         }


    }

    Connections{
        target: Controller
        function onObservationUpdated() {
            var list = Controller.getObservationData()

            lbl_startDate.text = qsTr(list[0])
            lbl_endDate.text = list[1]
            lbl_tle.text = list[2]
            lbl_max_altitude.text = list[3] + "°"
            lbl_rise_azimuth.text = list[4] + "°"
            lbl_set_azimuth.text = list[5] + "°"
            lbl_station_lat.text = list[6] + "°"
            lbl_station_lng.text = list[7] + "°"
            lbl_station_name.text = list[8]
            lbl_status.text = list[9]
            lbl_tle0.text = list[10]
            lbl_transmitter_description.text = list[11]
            lbl_id.text = list[12]

            waterfall.source = "file:" + list[13]
        }
    }

    Connections{
        target: Controller
        function onTransmissionUpdated() {
            var list = Controller.getTransmissionData()

            lbl_count_1.text = list[0]
            lbl_count_3.text = list[1]
            lbl_TransmissionDate.text = list[2]
        }
    }
}

