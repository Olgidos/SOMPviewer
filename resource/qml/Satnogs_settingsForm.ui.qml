import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Rectangle {
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"
    height: 288

    Layout.minimumHeight: 288

    //Layout.margins: 15
    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    property alias end_time_hour: end_time_hour
    property alias end_time_min: end_time_min
    property alias end_time_sec: end_time_sec
    property alias end_date_day: end_date_day
    property alias end_date_month: end_date_month
    property alias end_date_year: end_date_year
    property alias start_time_hour: start_time_hour
    property alias start_time_min: start_time_min
    property alias start_time_sec: start_time_sec
    property alias start_date_day: start_date_day
    property alias start_date_month: start_date_month
    property alias start_date_year: start_date_year
    property alias checkBox_keep_data: checkBox_keep_data

    property alias accept: accept
    property alias status: status
    property alias norad_id: norad_id

    Label {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
        id: label
        text: qsTr("SatNOGS")
        color: text_color
        font.pixelSize: 12
    }

    FontMetrics {
        id: fontMetrics
        font.family: "Verdana"
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 20

        Item {
            id: item1
            Layout.rightMargin: 5
            Layout.leftMargin: 5
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            Layout.fillHeight: false
            Layout.minimumHeight: 25
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true

            Text {
                id: text1
                width: 100
                text: qsTr("Norad ID:")
                color: text_color
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                //font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
            }

            TextField {
                id: norad_id
                anchors.left: text1.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.bottomMargin: 1
                anchors.topMargin: 1
                anchors.rightMargin: 0
                placeholderText: qsTr("")
                color: text_color
                text: "47445"
                background: Rectangle {
                    color: textbackground_color
                }
            }
        }

        // START DATE
        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 5
            Layout.topMargin: 15
            //            Layout.preferredHeight: 0
            //            Layout.preferredWidth: 0
            Layout.minimumHeight: 25

            Text {
                id: text_sd_01
                width: 100
                color: text_color
                text: qsTr("Start Date:")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                //font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }

            Text {
                id: text_sd_02
                width: 60
                color: text_color
                text: qsTr("Year - ")
                anchors.left: text_sd_01.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                //font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
            }

            TextField {
                id: start_date_year
                width: 70
                color: text_color

                anchors.left: text_sd_02.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                //placeholderText: qsTr("2020")
                text: qsTr("2021")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_sd_03
                width: 60
                color: text_color
                text: qsTr("Month - ")
                anchors.left: start_date_year.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                //font.pixelSize: 12
            }

            TextField {
                id: start_date_month
                width: 70
                color: text_color
                text: "01"
                anchors.left: text_sd_03.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_sd_04
                width: 60
                color: text_color
                text: qsTr("Day - ")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.left: start_date_month.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                //font.pixelSize: 12
            }

            TextField {
                id: start_date_day
                width: 70
                color: text_color
                text: "01"
                anchors.left: text_sd_04.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // START TIME
        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 5
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            Layout.minimumHeight: 25
            Text {
                id: text_st_01
                width: 100
                color: text_color
                text: qsTr("Start Time:")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }

            Text {
                id: text_st_02
                width: 60
                color: text_color
                text: qsTr("Second - ")
                anchors.left: text_st_01.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
            }

            TextField {
                id: start_time_sec
                width: 70
                color: text_color
                text: "00"
                anchors.left: text_st_02.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_st_03
                width: 60
                color: text_color
                text: qsTr("Minute - ")
                anchors.left: start_time_sec.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            TextField {
                id: start_time_min
                width: 70
                color: text_color
                text: "00"
                anchors.left: text_st_03.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_st_04
                width: 60
                color: text_color
                text: qsTr("Hour - ")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.left: start_time_min.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
            }

            TextField {
                id: start_time_hour
                width: 70
                color: text_color
                text: "00"
                anchors.left: text_st_04.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 442
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // END DATE
        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 5
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            Layout.minimumHeight: 25
            Layout.topMargin: 15
            Text {
                id: text_ed_01
                width: 100
                color: text_color
                text: qsTr("End Date:")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }

            Text {
                id: text_ed_02
                width: 60
                color: text_color
                text: qsTr("Year - ")
                anchors.left: text_ed_01.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
            }

            TextField {
                id: end_date_year
                width: 70
                color: text_color
                text: ""
                anchors.left: text_ed_02.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_ed_03
                width: 60
                color: text_color
                text: qsTr("Month - ")
                anchors.left: end_date_year.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            TextField {
                id: end_date_month
                width: 70
                color: text_color
                text: ""
                anchors.left: text_ed_03.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_ed_04
                width: 60
                color: text_color
                text: qsTr("Day - ")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.left: end_date_month.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
            }

            TextField {
                id: end_date_day
                width: 70
                color: text_color
                text: ""
                anchors.left: text_ed_04.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // END TIME
        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 5
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            Layout.minimumHeight: 25
            Text {
                id: text_et_01
                width: 100
                color: text_color
                text: qsTr("End Time:")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }

            Text {
                id: text_et_02
                width: 60
                color: text_color
                text: qsTr("Second - ")
                anchors.left: text_et_01.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 10
            }

            TextField {
                id: end_time_sec
                width: 70
                color: text_color
                text: ""
                anchors.left: text_et_02.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_et_03
                width: 60
                color: text_color
                text: qsTr("Minute - ")
                anchors.left: end_time_sec.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            TextField {
                id: end_time_min
                width: 70
                color: text_color
                text: ""
                anchors.left: text_et_03.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text_et_04
                width: 60
                color: text_color
                text: qsTr("Hour - ")
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.left: end_time_min.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
            }

            TextField {
                id: end_time_hour
                width: 70
                color: text_color
                text: ""
                anchors.left: text_et_04.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 442
                background: Rectangle {
                    color: textbackground_color
                }
                placeholderText: qsTr("")
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Status
        Item {
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 5
            Layout.preferredHeight: 0
            Layout.preferredWidth: 0
            Layout.minimumHeight: 30
            Layout.topMargin: 15

            Text {
                id: text6
                width: 100
                color: text_color
                text: qsTr("Status:")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
            }

            ComboBox {
                model: ["", "future", "good", "bad", "unknown", "failed"]
                id: status
                anchors.left: text6.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                currentIndex: 2
                anchors.leftMargin: 11
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                anchors.rightMargin: 1
            }
        }

        Item {
            id: item2
            Layout.topMargin: 3

            CheckBox {
                id: checkBox_keep_data
                anchors.top: parent.top
                anchors.right: accept.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 20
                width: 160
                height: 5

                Rectangle {
                    color: text_color
                }

                Text {
                    text: qsTr("Keep Data")
                    color: text_color
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                }
            }

            Button {
                id: accept
                width: 100
                text: qsTr("Download")
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.rightMargin: 5
            }

            Layout.fillHeight: false
            Layout.preferredHeight: 0
            Layout.fillWidth: true
            Layout.preferredWidth: 0
            Layout.minimumHeight: 25
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        Rectangle {
            id: rectangle
            width: 200
            height: 200
            color: "transparent"
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
