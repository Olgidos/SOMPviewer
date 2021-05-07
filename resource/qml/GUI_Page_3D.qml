import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Scene3D 2.15

Item {
    id: gui_page_3D
    anchors.fill: parent
    property bool grid_enabled: true
    property bool consume_lclick: false
    signal cameraChanged(int cam_id)

        Scene3D {
          id: scene3D
          anchors.fill: parent
          anchors.topMargin: 0
          anchors.leftMargin: 0
          anchors.bottomMargin: 0
          anchors.rightMargin: 0
          aspects: ["render", "logic", "input"]
          focus: true
          D3_Main { id: main3D }
        }


        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: {
                scene3D.focus = true
                if(!consume_lclick) mouse.accepted = false
            }
        }




        Overlay_Observation {
            id: obsOverlay
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
        }

        Overlay_Camera {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 10
        }

        Overlay_Play {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
        }

        Overlay_Axis {
            anchors.right: obsOverlay.left
            anchors.bottom: parent.bottom
            anchors.margins: 10
        }
}
