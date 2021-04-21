import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15



Rectangle {

    property alias image_src: button.icon.source
    property string type
    property color normal_color
    property color hover_color
    property color clicked_color_background
    property color clicked_color_icon

    id: base
    color: "transparent"
    Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
    Layout.fillWidth: true
    Layout.minimumHeight: 60
    Layout.minimumWidth: 60


        Button {
            width: height
            anchors.topMargin: 5
            anchors.top: parent.top
            anchors.bottom: label.top
            anchors.horizontalCenter: parent.horizontalCenter
            id: button
            //width: height
            text: qsTr("")
            //anchors.fill: parent
            icon.color: normal_color
            icon.height: 50
            icon.width: 50
            background.visible: false
            antialiasing: true
        }




    Label {
        id: label
        height: 12
        text: type
        anchors.bottomMargin: 5
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: normal_color
        antialiasing: true
        font.pixelSize: 11
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

    Rectangle {
        id: indicator
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 2
        color: normal_color
        visible: false
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: parent

        onEntered: {
            if(page != type) {
                base.color = hover_color
            }
        }


        onExited: {
            if(page != type) {
                base.color = "transparent"
            }
        }

        onClicked: {
            page = type
        }
    }


    Connections {
        target: general
        function onPageChanged() {
            evalPicked()
        }
    }


    Component.onCompleted : {
        evalPicked()
    }


    function evalPicked() {
        if(page == type) {
            base.color = clicked_color_background
            button.icon.color = clicked_color_icon
            indicator.visible = true
            return
        }

        base.color = "transparent"
        button.icon.color = normal_color
        indicator.visible = false
    }

}

