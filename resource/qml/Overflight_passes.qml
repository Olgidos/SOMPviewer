import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4


Rectangle {
    id: overflight_passes
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    //property list<ValueChart_item> item_list_valueChart
    property int passesAmount: 0
    property double highesDuration: 0


    Layout.minimumHeight: labelPasses.height + valuePassesGrid.height + 20

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    Label {
        id: labelPasses
        text: qsTr("Passes - no passes yet")
        color: text_color
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
    }

    ColumnLayout  {
        id: valuePassesGrid
        anchors.top: labelPasses.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        Layout.fillHeight: true
    }


    Connections{
        target: Controller
        function onPassesCalculated() {

            var list = Controller.getListPasses()

            if(list.length > 0) {
                labelPasses.text =  qsTr(list.length/2 + " Passes")
            } else {
                labelPasses.text =  qsTr("Passes - no passes yet")
            }

            highesDuration = 0
            for(var i = 0; i < list.length/3 ; i++){
                if(highesDuration <  list[i*3 + 1]){
                    highesDuration = list[i*3 + 1]
                }
            }

            for(var x = 0; x < list.length/3 ; x++){

                var o = Qt.createQmlObject('import QtQuick 2.15;
                                                  Overflight_passes_item {
                                                     val_id:' + x + ';
                                                  }'
                                               , valuePassesGrid);
                passesAmount++
            }

        }
    }


}


