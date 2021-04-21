import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.15

Rectangle {
    id: valueSelection
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    signal activateCalled(int val_id)
    signal deactivateCalled(int val_id)


    Layout.minimumHeight: textArea.height + label.height + 20

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    Label {
        id: label
        text: qsTr("Notes {")
        color: text_color
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
    }

    TextArea {
        id: textArea
        anchors.top: label.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 0
        antialiasing: true

        color: text_color
        text: "    This page allows the plotting of all information provided by the downloaded SatNOGS data in individual graphs.

    Controls (in Graph):
        - Drag mouse for zoom to a specific area
        - SHIFT + Scroll wheel UP/DOWN zoom in and out to the centre of the graph
        - Double click to reset zoom
        - Right-click to dis/enable point labels
}"
    }

}
