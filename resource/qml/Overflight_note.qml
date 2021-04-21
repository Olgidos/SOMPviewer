import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.15

Rectangle {
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"


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
        text: '    This form allows the user to predict satellite passes over an observer. It requires the user to specify the observers latitude and longitude,
    a combined start date, duration and the required minimum elevation. After the calculation, a graph will display the elevation and the illumination state of
    the satellite at their given dates. The latter is represented as a boolean with its positive state having the value of the minimum elevation.
    The controls of the graph are identical to the "value" section. The data which was calculated during the prediction is exported to .csv files under "./output/".
}'
    }

}
