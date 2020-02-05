import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Bugman")
    
    height: 720
    width: 520
//    color: palette.window
    
    property var nav: Navigation {}
    
    onClosing: {
        close.accepted = nav.isExitReady;
        nav.goBack();
    }
    
    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent
        
        Header {
            id: header
            z: 100
            Layout.fillWidth: true
            nav: root.nav
        }
        
        StackLayout {
            id: stackLayout
            width: 100
            height: 100
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: nav.index
            
            HomeView {
                id: homeView
                nav: root.nav
            }
            
            AboutView {
                id: aboutView
                nav: root.nav
            }
            
            EntryEditView {
                id: entryEditView
                nav: root.nav
            }
            
            SetEditView {
                id: setEditView
                nav: root.nav
            }
            
            SetSaveView {
                id: saveSetView
                nav: root.nav
            }
        }
    }
}


