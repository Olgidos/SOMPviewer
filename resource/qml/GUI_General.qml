import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    //id and page is used in sup-objects like Menu Entry in Connections
    id: general
    property string page: "home"

    anchors.fill: parent

    //Left side Menu
    Rectangle {
       id: menu
       color: "#232323"
       anchors.top: parent.top
       anchors.bottom: parent.bottom
       anchors.left: parent.left
       width: 78

     ColumnLayout {
           id: menuLayout
           anchors.fill: parent

           GUI_MenuEntry{
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               image_src: "qrc:/resource/images/home-1.png"
               type: "home"
           }

           GUI_MenuEntry{
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               image_src: "qrc:/resource/images/layers.png"
               type: "values"
           }

           GUI_MenuEntry{
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               image_src: "qrc:/resource/images/worldwide.png"
               type: "3D"
           }


           GUI_MenuEntry{
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               image_src: "qrc:/resource/images/binoculars.png"
               type: "overflights"
           }


           GUI_MenuEntry{
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               image_src: "qrc:/resource/images/settings.png"
               type: "settings"
           }


           Rectangle {
               id: space
               width: 200
               height: 200
               color: "#00ffffff"
               Layout.fillWidth: true
               Layout.fillHeight: true
           }


           Menu_controller{
               Layout.fillWidth: true
               height: 180
               normal_color: "#e7e7e7"
               hover_color: "#66e7e7e7"
               clicked_color_background: "#111111"
               clicked_color_icon: "#8dc0e3"
               Layout.bottomMargin: 10
           }
      }
     }

     //Right side MainWindow
     Rectangle {
         color: "#333333"
         anchors.top: parent.top
         anchors.bottom: parent.bottom
         anchors.left: menu.right
         anchors.right: parent.right

         GUI_Page_Home {
             id: home
             visible: true
         }

         GUI_Page_Settings {
             id: settings
             visible: false
         }

         GUI_Page_Values {
             id: values
             visible: false
         }

         GUI_Page_3D {
             id: _3D
             visible: false
         }

         GUI_Page_Overflight {
             id: overflight
             visible: false
         }

     }

     Rectangle {
         id: busy
         visible: false
         width: 200
         height: 200
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         color: "transparent"

         BusyIndicator {
             anchors.fill: parent
             palette.dark: "#e7e7e7"
         }
     }
     Connections {
         target: general
         function onPageChanged() {
             home.visible = false;
             settings.visible = false;
             values.visible = false;
             _3D.visible = false;
             overflight.visible = false;

             if(page == "home") home.visible = true
             if(page == "settings") settings.visible = true
             if(page == "values") values.visible = true
             if(page == "3D") {
                 console.log("Loading 3D files < 1 min")
                 _3D.visible = true
             }

             if(page == "overflights") overflight.visible = true
         }
     }



     Connections{
         target: Controller
         function onCalculating() {
             busy.visible = true
         }
     }

     Connections{
         target: Controller
         function onCalculatingFinished() {
             busy.visible = false
         }
     }

     Component.onCompleted : {
         Controller.loadData()
     }

}
