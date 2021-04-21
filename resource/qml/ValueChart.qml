import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4


Rectangle {
    id: valuecharts
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    //property list<ValueChart_item> item_list_valueChart
    property int chartAmount: 0
    property var activate: chartActivated
    property var deactivate: chartDeactivated
    signal forwardToCharts_activate(int chart_id)
    signal forwardToCharts_deactivate(int chart_id)

    Layout.minimumHeight: labelCharts.height + valueChartGrid.height + 20

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    Label {
        id: labelCharts
        text: qsTr("Charts")
        color: text_color
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
    }

    ColumnLayout  {
        id: valueChartGrid
        anchors.top: labelCharts.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        Layout.fillHeight: true
    }


    function chartActivated(val_id) {
        forwardToCharts_activate(val_id)
    }

    function chartDeactivated(val_id) {
        forwardToCharts_deactivate(val_id)
    }



    Connections{
        target: Controller
        function onDataAvailable() {
            if(Controller.getListNames().length > chartAmount ) {

                for(var x = chartAmount; x < Controller.getListNames().length; x++){

                    var o = Qt.createQmlObject('import QtQuick 2.15;
                                                      ValueChart_item {
                                                         visible: false;
                                                         val_id:' + x + ';
                                                      }'
                                                   , valueChartGrid);
                    chartAmount++
                }
            }

        }
    }




    Connections{
        target: Controller
        function onDataReseted() {

        }
    }

}


