import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

ScrollView {
    id: scrollview
    anchors.fill: parent

    property alias activated: valuecharts.activate
    property alias deactivated: valuecharts.deactivate

    ScrollBar.vertical.policy: ScrollBar.AlwaysOn
    ScrollBar.vertical.visible: ScrollBar.vertical.size < 1

    clip: true
    padding: 1


    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.rightMargin: 15
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        spacing: 20

        ValueNotes {
            id: valueNotes
            Layout.fillWidth: true
        }

        ValueSelection {
           id: valueSelection
           Layout.fillWidth: true
        }

        ValueChart {
            id: valuecharts
            Layout.fillWidth: true
        }


        Rectangle {
            color: "#00ffffff"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: {
        valueSelection.activateCalled.connect(valuecharts.activate)
        valueSelection.deactivateCalled.connect(valuecharts.deactivate)
    }

}
