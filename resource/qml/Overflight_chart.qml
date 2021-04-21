import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4
import QtCharts 2.15

Rectangle {
    id: valuecharts
    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    Layout.minimumHeight: labelCharts.height + valueChartGrid.height + 20

    signal forwardToCharts_activate(int chart_id)
    signal forwardToCharts_deactivate(int chart_id)

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color


    Label {
        id: labelCharts
        text: qsTr("Chart")
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


        Rectangle {
            property alias text: label.text
            property color text_color: "#e7e7e7"
            property int val_id

            visible: false
            val_id: -100
            id: chart_item

            Layout.fillWidth: true
            height: 500

            color: "transparent"

            Label {
                id: label
                color: text_color
                height: 20
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 10
                anchors.leftMargin: 5
                font.pixelSize: 12
            }

            Label {
                id: labelUnit
                color: text_color
                height: 20
                anchors.top: label.bottom
                anchors.left: parent.left
                anchors.leftMargin: 5
                font.pixelSize: 12
            }


            ChartView {
                id: chart
                antialiasing: true
                backgroundColor: "transparent"
                legend.visible: false
                clip: true
                anchors.top: labelUnit.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                margins.top: 0
                margins.bottom: 0
                margins.left: 0
                margins.right: 0
                backgroundRoundness: 0

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    preventStealing: true
                    propagateComposedEvents: true
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    ToolTip.delay: 1000
                    ToolTip.timeout: 2000
                    ToolTip.visible: hovered
                    ToolTip.text: qsTr("mous drag rectangle: zoom; double click: reset; shift + wheel: zoom rightclick: values on/off")

                    Rectangle {
                        property int init_x: 0
                        property int init_y: 0
                        id: rect_select
                        color: "transparent"
                        visible: false
                        border.width: 2
                        border.color: border_color
                    }

                    onPressed: {
                        if(mouse.button & Qt.LeftButton) {
                            rect_select.x = mouse.x
                            rect_select.y = mouse.y
                            rect_select.init_x = rect_select.x
                            rect_select.init_y = rect_select.y
                            rect_select.width = 0
                            rect_select.height = 0
                            rect_select.visible = true
                        }

                        if(mouse.button & Qt.RightButton) {
                            series_passes.pointLabelsVisible = !series_passes.pointLabelsVisible
                        }

                    }

                    onPositionChanged: {

                        if(mouse.x - rect_select.init_x >= 0) {
                            rect_select.width = mouse.x - rect_select.x
                        }else {
                            rect_select.x = mouse.x
                            rect_select.width = rect_select.init_x - mouse.x
                        }

                        if(mouse.y - rect_select.init_y >= 0) {
                            rect_select.height = mouse.y - rect_select.y
                        }else {
                            rect_select.y = mouse.y
                            rect_select.height = rect_select.init_y - mouse.y

                        }
                    }

                    onReleased: {
                        if(mouse.button & Qt.LeftButton) {
                            var r = Qt.rect(rect_select.x, rect_select.y, rect_select.width, rect_select.height)
                            chart.zoomIn(r)
                            rect_select.visible = false
                        }

                    }

                    onWheel: {
                        if((wheel.modifiers & Qt.ShiftModifier)) {
                            if(wheel.angleDelta.y < 0) chart.zoom(0.9)
                            if(wheel.angleDelta.y > 0) chart.zoom(1.1111)
                        }
                        else {
                            wheel.accepted = false
                        }
                    }

                    onDoubleClicked: {
                        if(mouse.button & Qt.LeftButton) {
                            chart.zoomReset()
                        }
                    }
                }


                DateTimeAxis {
                    id: xAxis
                    labelsVisible: true
                    gridVisible:true
                    minorGridVisible:true
                    tickCount: 7
                    labelsFont.pixelSize: 10
                    labelsColor: "#bcbaba"
                    gridLineColor: border_color
                }

                ValueAxis {
                    id: yAxis
                    labelsVisible: true
                    gridVisible: true
                    minorGridVisible: false
                    tickCount: 6
                    labelsColor: "#bcbaba"
                    labelsFont.pixelSize: 10
                    minorGridLineColor: border_color
                    gridLineColor: border_color
                    //titleText: "<font color='white'>YourTitle</font>"
                }

                LineSeries {
                    id: series_passes
                    color: "#ffc505"
                    axisX: xAxis
                    axisY: yAxis
                    name: "Passes"
                    useOpenGL: false;
                    pointsVisible: true
                    pointLabelsVisible: false
                    pointLabelsFormat: "@yPoint"
                    pointLabelsColor: "#bcbaba"
                }

                LineSeries {
                    id: series_illu
                    color: "#fd8a7d"
                    axisX: xAxis
                    axisY: yAxis
                    name: "Illumination"
                    useOpenGL: false;
                    pointsVisible: true
                    pointLabelsVisible: false
                    pointLabelsFormat: "@yPoint"
                    pointLabelsColor: "#bcbaba"
                }
            }


            function updateChart(_chart_id) {

                if(_chart_id === val_id) {
                    Controller.updateChart_overflight(series_passes, series_illu, xAxis, yAxis)
                    yAxis.titleText = "Elevation"
                    labelUnit.text = "in [°]"
                    text = "Elevation of S/C over observer [orange], secundary info about the illumination state of the S/C (high = illuminated, low = in shadow) [red]"
                    chart_item.visible = true
                    yAxis.applyNiceNumbers()
                }
            }

            function hideChart(_chart_id) {

                if(_chart_id === val_id) {
                    chart_item.visible = false
                }
            }

            Component.onCompleted : {
                forwardToCharts_activate.connect(updateChart)
                forwardToCharts_deactivate.connect(hideChart)
            }


            Connections{
                target: Controller
                function onDataReseted() {
                    chart_item.visible = false
                }
            }
        }

    }

    Connections {
        target: Controller
        function onPassesCalculated() {
            forwardToCharts_activate(-100);
        }
     }

}


