import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    property color color_icon: "#e7e7e7"
    property color color_icon_clicked: "#8dc0e3"
    radius: 5
    color: "#95232323"
    width: 60
    height: 22

    RowLayout {

        anchors.fill: parent
        anchors.margins: 1
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.bottomMargin: 3

        Label {
            id: x
            //width: 10
            text: qsTr("x")
            color: "#2347BD"
            font.pixelSize: 16
        }

        Label {
            id: y
            //width: 10
            text: qsTr("y")
            color: "#B30600"
            font.pixelSize: 16
        }

        Label {
            id: z
            //width: 10
            text: qsTr("z")
            color: "#00C914"
            font.pixelSize: 16
        }
    }
}
