import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Scene3D 2.15
import QtQuick.Layouts 1.15

Window {
    id: mainview
    width: 1400
    height: 720
    visible: true
    flags: Qt.Window
    title: "SOMP 2B Data Loader"
    property QtObject object

    GUI_General {}
}
