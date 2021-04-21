import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    property color color_icon: "#e7e7e7"
    property color color_icon_clicked: "#8dc0e3"
    radius: 5
    color: "#95232323"
    width: 40
    height: 120

    Button {
        id: button0
        width: height
        anchors.topMargin: 0
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("")
        icon.color: color_icon_clicked
        icon.height: 25
        icon.width: 25
        icon.source: "qrc:/resource/images/radar.png"
        background.visible: false
        antialiasing: true

        hoverEnabled: true
        ToolTip.delay: 1000
        ToolTip.timeout: 5000
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Free camera in ICRS, image up/down: zoom; arrow keys: translation; left click: rotation")

        onClicked: {
            cameraChanged(0);
            bttnReset();
            icon.color = color_icon_clicked;
        }
    }

    Button {
        id: button1
        width: height
        anchors.topMargin: 0
        anchors.top: button0.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("")
        icon.color: color_icon
        icon.height: 25
        icon.width: 25
        icon.source: "qrc:/resource/images/eci.png"
        background.visible: false
        antialiasing: true

        hoverEnabled: true
        ToolTip.delay: 1000
        ToolTip.timeout: 5000
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Orbit camera in ECI, wheel: zoom; right click: rotation")

        onClicked: {
            cameraChanged(1);
            bttnReset();
            icon.color = color_icon_clicked;
        }
    }

    Button {
        id: button2
        width: height
        anchors.topMargin: 0
        anchors.top: button1.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("")
        icon.color: color_icon
        icon.height: 25
        icon.width: 25
        icon.source: "qrc:/resource/images/satellite.png"
        background.visible: false
        antialiasing: true

        hoverEnabled: true
        ToolTip.delay: 1000
        ToolTip.timeout: 5000
        ToolTip.visible: hovered
        ToolTip.text: qsTr("Orbit camera satellite, wheel: zoom; right click: rotation")

        onClicked: {
            cameraChanged(2);
            bttnReset();
            icon.color = color_icon_clicked;
        }
    }

    function bttnReset() {
        button0.icon.color = color_icon
        button1.icon.color = color_icon
        button2.icon.color = color_icon
    }


}
