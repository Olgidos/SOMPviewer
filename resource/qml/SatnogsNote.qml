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
        text: '    The SatNOGs form allows downloading all satellite observations by the network between the start and the end date. Thereby the id specifies the
    spacecraft and the status the quality of the observations. If fields let empty the API request won\'t respect this parameter.
    The results are provided inside the "/download" folder in form of .json, .png files and "data_" files. The latter is then post-processed
    by the "/python/decode.py" and again saved in "/downloads/decoded_*.json".
}'
    }

}
