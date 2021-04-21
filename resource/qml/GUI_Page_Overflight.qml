import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4

ScrollView {
    id: scrollview
    anchors.fill: parent

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

        Overflight_note {
            id: overflight_note
            Layout.fillWidth: true
        }

        Overflight_settings {
            id: overflight_settings
            Layout.fillWidth: true
        }

        Overflight_chart {
            id: overflight_chart
            Layout.fillWidth: true
        }

        Overflight_passes {
            id: overflight_passes
            Layout.fillWidth: true
        }



        Rectangle {
            color: "#00ffffff"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

}
