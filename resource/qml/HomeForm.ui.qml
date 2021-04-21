import QtQuick 2.15

Item {
    width: 400
    height: 400
    anchors.fill: parent

    Text {
        id: text1
        x: 18
        y: 0
        width: 318
        height: 122
        text: qsTr("HOME")
        font.pixelSize: 100
        minimumPixelSize: 40
        color: "#e7e7e7"
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 120
        width: 350
        height: 2
        color: "#232323"

    }

    Text {
        id: text2
        x: 18
        y: 133
        width: 215
        height: 17
        text: qsTr("Tu Dresden - SOMP 2b")
        font.pixelSize: 12
        color: "#e7e7e7"
    }

    Text {
        id: text3
        x: 18
        y: 150
        width: 215
        height: 17
        text: qsTr("by H. Blättermann")
        font.pixelSize: 12
        color: "#e7e7e7"
    }
}
