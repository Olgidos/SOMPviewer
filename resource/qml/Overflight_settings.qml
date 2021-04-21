import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4

Rectangle {
    id: settings_overflight

    property color text_color: "#e7e7e7"
    property color textbackground_color: "#232323"
    property color border_color: "#232323"

    Layout.minimumHeight: rect_obs_pos.height + label.height + rect_start_date.height
                          + rect_start_time.height
                          + rect_duration.height + 65

    color: "transparent"
    radius: 5
    border.width: 1
    border.color: border_color

    Label {
        id: label
        text: qsTr("Overflight Settings:")
        color: text_color
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10
    }


    Rectangle {
        id: rect_obs_pos
        height: 25

        anchors.top: label.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.leftMargin: 20

        color: "transparent"


        RowLayout {
            anchors.fill: parent
            spacing: 20

            Label {
                text: qsTr("Observer Longitude:")
                color: text_color
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
            }

            TextField {
                id: txt_lon
                color: text_color
                Layout.minimumWidth: 150
                Layout.fillHeight: true
                Layout.fillWidth: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: qsTr("13.7373")
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: qsTr("Observer Latitude:")
                verticalAlignment: Text.AlignVCenter
                color: text_color
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: txt_lat
                color: text_color
                Layout.minimumWidth: 150
                Layout.fillHeight: true
                Layout.fillWidth: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: qsTr("51.0504")
                horizontalAlignment: Text.AlignHCenter
                Layout.rightMargin: 5
            }

        }
    }


    Rectangle {
        id: rect_start_date
        height: 25

        anchors.top: rect_obs_pos.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.leftMargin: 20

        color: "transparent"


        RowLayout {
            anchors.fill: parent
            spacing: 10

            Label {
                text: qsTr("Start Year:")
                color: text_color
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.minimumWidth: 75
            }

            TextField {
                id: start_year
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getUTCFullYear()
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: qsTr("Month:")
                verticalAlignment: Text.AlignVCenter
                color: text_color
                Layout.fillHeight: true
                Layout.minimumWidth: 75
            }

            TextField {
                id: start_month
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getMonth() +1
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: qsTr("Day:")
                verticalAlignment: Text.AlignVCenter
                color: text_color
                Layout.fillHeight: true
                Layout.minimumWidth: 75
            }

            TextField {
                id: start_day
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getUTCDate()
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                color: "transparent"
            }
        }
    }



    Rectangle {
        id: rect_start_time
        height: 25

        anchors.top: rect_start_date.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.leftMargin: 20

        color: "transparent"


        RowLayout {
            anchors.fill: parent
            spacing: 10

            Label {
                text: qsTr("Start Hour:")
                color: text_color
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.minimumWidth: 75

            }

            TextField {
                id: start_hour
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getUTCHours()
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: qsTr("Minute:")
                verticalAlignment: Text.AlignVCenter
                color: text_color
                Layout.fillHeight: true
                Layout.minimumWidth: 75
            }

            TextField {
                id: start_minute
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getUTCMinutes()
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: qsTr("Seconds:")
                verticalAlignment: Text.AlignVCenter
                color: text_color
                Layout.fillHeight: true
                Layout.minimumWidth: 75
            }

            TextField {
                id: start_second
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: {
                    var now = new Date;
                    return now.getUTCSeconds()
                }
                horizontalAlignment: Text.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                color: "transparent"
            }
        }
    }


    Rectangle {
        id: rect_duration
        height: 25

        anchors.top: rect_start_time.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.leftMargin: 20

        color: "transparent"


        RowLayout {
            anchors.fill: parent
            spacing: 20

            Label {
                text: qsTr("Timespan in days:")
                color: text_color
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.minimumWidth: 125
                Layout.maximumWidth: 125

            }

            TextField {
                id: timespan
                color: text_color
                Layout.minimumWidth: txt_elevation.width
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumWidth: txt_elevation.width
                background: Rectangle {
                    color: textbackground_color
                }
                text: "10"
                horizontalAlignment: Text.AlignLeft
            }

            Rectangle {
                Layout.fillWidth: true
                color: "transparent"
            }
        }
    }


    Rectangle {
        id: rect_elevation
        height: 25

        anchors.top: rect_duration.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 5
        anchors.leftMargin: 20

        color: "transparent"


        RowLayout {
            anchors.fill: parent
            spacing: 20

            Label {
                text: qsTr("Minimum Elevation:")
                color: text_color
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.minimumWidth: 125
                Layout.maximumWidth: 125

            }

            TextField {
                id: txt_elevation
                color: text_color
                Layout.minimumWidth: 75
                Layout.fillHeight: true
                Layout.fillWidth: true
                background: Rectangle {
                    color: textbackground_color
                }
                text: "30"
                horizontalAlignment: Text.AlignLeft
            }

            Button {
                id: run
                Layout.fillHeight: true
                width: 100
                text: qsTr("Calculate")
                Layout.rightMargin: 5
                onPressed: settings_overflight.run()
            }
        }
    }

    function run() {
        Controller.setOverflight(txt_lat.text, txt_lon.text,
                                 start_year.text, start_month.text, start_day.text,
                                 start_hour.text, start_minute.text, start_second.text,
                                 timespan.text, txt_elevation.text);
    }
}

























