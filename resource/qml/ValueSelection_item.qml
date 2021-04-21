import QtQuick 2.15;
import QtQuick.Controls 2.15;

Rectangle {
    property alias text: label.text
    property color text_color: "#e7e7e7"
    property int val_id
    signal activated(int val_send_id)
    signal deactivated(int val_send_id)

    id: val_item
    height: 30
    width: 100
    color: "transparent"

    CheckBox {
        id: checkBox
        height: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 1
        onClicked: {
            if (checkBox.checked) {
                activated(val_id)
            }

            else {
                deactivated(val_id)
            }
        }
    }

    Label {
        id: label
        color: text_color
        height: 20
        anchors.verticalCenter: checkBox.verticalCenter
        anchors.left: checkBox.right
        font.pixelSize: 12
    }

    Component.onCompleted: {
        activated.connect(itemActivated)
        deactivated.connect(itemDeactivated)
    }

    Connections{
        target: Controller
        function onDataReseted() {
            activated.disconnect(itemActivated)
            deactivated.disconnect(itemDeactivated)
            val_item.destroy(0)
        }
    }
}
