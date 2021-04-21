import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4


Rectangle {
    id: valueSelection
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    signal activateCalled(int val_id)
    signal deactivateCalled(int val_id)


    Layout.minimumHeight: valueSelectionGrid.height + label.height + 20

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    Label {
        id: label
        text: qsTr("Values - No Data available")
        color: text_color
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
    }

    GridLayout  {
        id: valueSelectionGrid
        anchors.top: label.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        Layout.fillHeight: true
        columns: 4
    }


    function itemActivated(val_id) {
        activateCalled(val_id);
    }

    function itemDeactivated(val_id) {
        deactivateCalled(val_id);
    }


    Connections{
        target: Controller
        function onDataAvailable() {

            if(Controller.getListNames().length > 0 ) {
                label.text = "Values"

                for(var x = 0; x < Controller.getListNames().length; x++){

                    var s = 'import QtQuick 2.15;
                                        ValueSelection_item {
                                             text: qsTr("' + Controller.getListNames()[x] + '");
                                             val_id:' + x + '
                                        }'

                    var o = Qt.createQmlObject(s, valueSelectionGrid);
                }
            }
        }
    }

    Connections{
        target: Controller
        function onDataReseted() {
            label.text = "Values - No Data available"
        }
    }


}


