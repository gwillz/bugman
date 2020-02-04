import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Bugman")
    
    height: 900
    width: 520
//    color: palette.window
    
    function isHome() {
        return stackLayout.currentIndex === Views.home;
    }
    
    function navigate(index) {
        stackLayout.currentIndex = index;
    }
    
    onClosing: {
        if (!isHome()) {
            close.accepted = false;
            root.navigate(Views.home);
        }
    }
    
    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent
        
        Header {
            id: header
            z: 100
            Layout.fillWidth: true
            isHome: root.isHome()
            onNav: root.navigate(index)
        }
        
        StackLayout {
            id: stackLayout
            width: 100
            height: 100
            Layout.fillWidth: true
            Layout.margins: 10
            currentIndex: Views.home
            
            HomeView {
                id: homeView
                onNav: root.navigate(index)
            }
            
            AboutView {
                id: aboutView
                onNav: root.navigate(index)
            }
            
            EntryEditView {
                id: entryEditView
                onNav: root.navigate(index)
                navIndex: stackLayout.currentIndex
            }
            
            SetEditView {
                id: setEditView
                onNav: root.navigate(index)
            }
            
            SetSaveView {
                id: saveSetView
                onNav: root.navigate(index)
            }
        }
    }
}


