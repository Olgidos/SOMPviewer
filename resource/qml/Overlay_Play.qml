import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15


Rectangle {
    property color color_icon: "#e7e7e7"
    property color color_icon_clicked: "#8dc0e3"
    property color text_color: "#e7e7e7"

    property int date_height: 30

    radius: 5
    color: "#95232323"
    width: 275
    height: 60

    Rectangle {
        id: rect_date
        width: parent.width
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: date_height
        color: "transparent"

        TextField {
            id: day
            width: 35
            text: qsTr("20")

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
            horizontalAlignment: Qt.AlignVCenter
        }

        Label {
            id: sec1
            width: 5
            text: "."
            height: date_height

            anchors.topMargin: 7
            anchors.leftMargin: -5
            anchors.left: day.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Rectangle {
                anchors.fill: parent
                color: "transparent"
            }

            color: text_color
            font.pixelSize: 14
        }

        TextField {
            id: month
            width: 35
            text: qsTr("01")

            anchors.left: sec1.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -5

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }

        Label {
            id: sec2
            width: 5
            text: qsTr(".")

            anchors.topMargin: 7
            anchors.left: month.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -5

            color: text_color
            font.pixelSize: 14
        }

        TextField {
            id: year
            width: 55
            text: qsTr("2000")

            anchors.left: sec2.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -5

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }



        TextField {
            id: hours
            width: 35
            text: qsTr("20")

            anchors.left: year.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -5

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }

        Label {
            id: sec3
            width: 5
            text: qsTr(":")

            anchors.topMargin: 7
            anchors.left: hours.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: -5

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }

        TextField {
            id: minutes
            width: 35
            text: qsTr("01")

            anchors.leftMargin: -5
            anchors.left: sec3.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }

        Label {
            id: sec4
            width: 5
            text: qsTr(":")

            anchors.topMargin: 7
            anchors.leftMargin: -5
            anchors.left: minutes.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            color: text_color
            font.pixelSize: 14
        }

        TextField {
            id: seconds
            width: 35
            text: qsTr("12")

            anchors.leftMargin: -5
            anchors.left: sec4.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            background: Rectangle {
                color: "transparent"
            }
            color: text_color
            font.pixelSize: 14
        }

        Button {
            id: set_btn
            width: date_height
            height: date_height
            anchors.topMargin: 0
            anchors.top: parent.top
            anchors.left: seconds.right
            anchors.leftMargin: 2
            text: qsTr("")
            icon.color: color_icon
            icon.height: date_height
            icon.width: date_height
            icon.source: "qrc:/resource/images/checked-1.png"
            background.visible: false
            antialiasing: true

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Set date")

            onClicked: {
                Controller.set_date( day.text , month.text, year.text, hours.text, minutes.text, seconds.text);
            }
        }

        Button {
            id: reset_btn
            width: date_height
            height: date_height
            anchors.topMargin: 0
            anchors.top: parent.top
            anchors.left: set_btn.right
            anchors.leftMargin: -2
            text: qsTr("")
            icon.color: color_icon
            icon.height: date_height
            icon.width: date_height
            icon.source: "qrc:/resource/images/multiply-1.png"
            background.visible: false
            antialiasing: true

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Reset date")

            onClicked: {
                Controller.reset_date()
            }
        }
    }

    Rectangle {
        id: rect_speed
        width: parent.width
        anchors.left: parent.left
        anchors.top: rect_date.bottom
        anchors.right: parent.right
        height: date_height
        color: "transparent"

        Button {
            id: icon_speed
            width: date_height +6
            height: date_height +6
            anchors.topMargin: -6
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 0
            text: qsTr("")
            icon.color: color_icon
            icon.height: date_height +6
            icon.width: date_height +6
            icon.source: "qrc:/resource/images/volume-control-1.png"
            background.visible: false
            antialiasing: true

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Reset date")

        }


        Slider {
            id: slider_speed
            height: date_height -4
            width: 173
            anchors.left: icon_speed.right
            anchors.leftMargin: -5
            anchors.verticalCenter: parent.verticalCenter

            value: 0.5
            stepSize: 0

            background: Rectangle {
                x: slider_speed.leftPadding
                y: slider_speed.topPadding + slider_speed.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 2
                width: slider_speed.availableWidth
                height: implicitHeight
                radius: 2
                color: "#232323"

                Rectangle {
                    width: (slider_speed.visualPosition - 0.5) * parent.width
                    height: parent.height
                    anchors.left: parent.horizontalCenter
                    color: "#ffc505"
                    radius: 2
                }

                Rectangle {
                    width: (slider_speed.visualPosition - 0.5) * parent.width * -1
                    height: parent.height
                    anchors.right: parent.horizontalCenter
                    color: "#ffc505"
                    radius: 2
                }

            }

            handle: Rectangle {
                x: slider_speed.leftPadding + slider_speed.visualPosition * (slider_speed.availableWidth - width)
                y: slider_speed.topPadding + slider_speed.availableHeight / 2 - height / 2
                implicitWidth: 18
                implicitHeight: 18
                radius: 9
                color: slider_speed.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }
        }

        TextField {
            id: speed
            width: 20
            text: {
                var i = Math.sign(slider_speed.value - 0.5) * Math.pow(10, 7.5*Math.abs(slider_speed.value - 0.5))
                return i .toFixed(1)
            }


            background: Rectangle {
                color: "transparent"
            }

            anchors.topMargin: 3
            anchors.leftMargin: -5
            anchors.left: slider_speed.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            color: "#ffc505"
            font.pixelSize: 14

            onAccepted: {
                var i = 0
                if (text > 0) i = Math.log10(text) / 7.5 + 0.5
                else i = 0.5 - Math.log10(Math.abs(text)) / 7.5
                slider_speed.value = i
            }

            onTextChanged: {
                Controller.set_speed(text);
            }
        }

    }

    Connections{
        target: Controller
        function onDateUpdated() {
            var data = Controller.getPlaybackDate()

            for(var i = 0; i < 6; i++) {
                if(data[i] < 10) data[i] = "0"+data[i]
            }

            day.text = data[0]
            month.text = data[1]
            year.text = data[2]

            seconds.text = data[3]
            minutes.text = data[4]
            hours.text = data[5]
        }
    }

}
