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
        //font.pixelSize: 12
    }

    Label {
        id: label_duration
        color: text_color
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: label_time.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        anchors.margins: 5
        anchors.leftMargin: 30
        //font.pixelSize: 12
    }



    Component.onCompleted : {
        text =  "Pass at: " + Controller.getListPasses()[val_id*2]
        label_duration.text =  "Duration: " + Controller.getListPasses()[val_id*2 +1]
                + " s"
        if(highesDuration < Controller.getListPasses()[val_id*2 +1]){
            highesDuration = Controller.getListPasses()[val_id*2 +1]
        }
        setColor.connect(color_setup)
    }

    function color_setup() {
        color = Qt.hsla( (Controller.getListPasses()[val_id*2 +1]/highesDuration) * 0.33 ,1,0.5,0.1)
    }



    Connections{
        target: Controller
        function onPassesCalculated() {
            passesAmount--;
            setColor.disconnect(color_setup)
            passes_item.destroy();
        }
    }
}
