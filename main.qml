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
    
    onClosing: {
        close.accepted = Navigation.isExitReady;
        Navigation.goBack();
    }
    
    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent
        
        Header {
            id: header
            z: 100
            Layout.fillWidth: true
        }
        
        StackLayout {
            id: stackLayout
            width: 100
            height: 100
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: Navigation.index
            
            HomeView {
                id: homeView
            }
            
            AboutView {
                id: aboutView
            }
            
            EntryEditView {
                id: entryEditView
            }
            
            SetEditView {
                id: setEditView
            }
            
            SetSaveView {
                id: saveSetView
            }
        }
    }
}


