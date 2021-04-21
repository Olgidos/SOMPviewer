import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ColumnLayout {
//    property alias image_src_play: button_play.icon.source
   property string image_src_play: "qrc:/resource/images/play-button.png"
   property string image_src_pause: "qrc:/resource/images/pause.png"
   property string image_src_next: "qrc:/resource/images/next.png"
   property string image_src_back: "qrc:/resource/images/back.png"


    property color normal_color
    property color hover_color
    property color clicked_color_background
    property color clicked_color_icon

    property color play_color: "#7fc241"


    Rectangle {
        height: 1
        color: "#40e7e7e7"
        Layout.fillWidth: true
        Layout.bottomMargin: 3
    }


    Rectangle {
        id: rect_play
        color: "transparent"
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Layout.fillWidth: true
        Layout.minimumHeight: 33

        Button {
            id: button_play
            height: 30
            text: qsTr("")
//            icon.height: button_next.height
            icon.source: image_src_play
            icon.color: "#7fc241"
            icon.width: button_play.width
            icon.height: button_play.height
            background.visible: false
            antialiasing: true
            anchors.fill: parent

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("use in 3D to un/pause")


            property bool play_bool: false

            onClicked: {
                rect_play.color = clicked_color_background

                if(!play_bool) {
                    icon.source = image_src_pause
                    icon.color = normal_color
                    play_bool = true
                } else {
                    icon.source = image_src_play
                    icon.color = play_color
                    play_bool = false
                }

                Controller.set_play_pause(play_bool)
                stateTimer_play.start()
            }
        }

        Timer {
            id: stateTimer_play
            interval: 50;
            repeat: false
            onTriggered: rect_play.color = "transparent"
        }
    }






    Rectangle {
        id: rect_next
        color: "transparent"
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Layout.fillWidth: true
        Layout.minimumHeight: 33

        Button {
            id: button_next
            height: 30
            text: qsTr("")
            icon.color: normal_color
//            icon.height: button_next.height
            icon.source: image_src_next
            background.visible: false
            antialiasing: true
            anchors.fill: parent
            icon.width: button_next.width
            icon.height: button_next.height

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("use in 3D to jump to the next transmission")

            onClicked: {
                rect_next.color = clicked_color_background
                Controller.nextTransmission()
                stateTimer_next.start()
            }
        }

        Timer {
            id: stateTimer_next
            interval: 50;
            repeat: false
            onTriggered: rect_next.color = "transparent"
        }
    }


    Rectangle {
        id: rect_back
        color: "transparent"
        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
        Layout.fillWidth: true
        Layout.minimumHeight: 33

        Button {
            id: button_back
            height: 30
            text: qsTr("")
            anchors.fill: parent
            icon.color: normal_color
//            icon.height: button_back.height
            icon.source: image_src_back
            background.visible: false
            antialiasing: true
            icon.width: button_back.width
            icon.height: button_back.height

            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("use in 3D to jump to the previous transmission")

            onClicked: {
                rect_back.color = clicked_color_background
                Controller.previousTransmission()
                stateTimer_back.start()
            }
        }

        Timer {
            id: stateTimer_back
            interval: 50;
            repeat: false
            onTriggered: rect_back.color = "transparent"
        }

    }

}
