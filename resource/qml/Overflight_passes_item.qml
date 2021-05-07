import QtQuick 2.15;
import QtQuick.Controls 2.15;
import QtCharts 2.15
import QtQuick.Layouts 1.15


Rectangle {
    property alias text: label_time.text
    property color text_color: "#e7e7e7"
    property int val_id

    id: passes_item

    Layout.fillWidth: true
    height: 20
    radius: 5

    color: "transparent"

    Label {
        id: label_time
        color: text_color
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 5
        anchors.leftMargin: 30
        verticalAlignment: Text.AlignVCenter
        width: 300
    }

    Label {
        id: label_max_elevation
        color: text_color
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: label_duration.left
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.margins: 5
        anchors.leftMargin: 30
    }

    Label {
        id: label_duration
        color: text_color
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 150
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.margins: 5
        anchors.leftMargin: 5
    }



    Component.onCompleted : {
        var list = Controller.getListPasses()

        text =  "Pass at: " + list[val_id*3]
        label_duration.text =  "Duration: " + list[val_id*3 +1]
                + " s"
        label_max_elevation.text = "Max. Elvevation: " + list[val_id*3 +2].toFixed(2)
                + " deg"

        color = Qt.hsla( (list[val_id*3 +1]/highesDuration) * 0.45 ,1,0.5,0.1)
    }




    Connections{
        target: Controller
        function onPassesCalculated() {
            passesAmount--;
            passes_item.destroy();
        }
    }
}
