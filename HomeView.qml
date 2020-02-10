import QtQuick 2.12
import QtQuick.Controls 2.13

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    function onNav() {
        const {index, data} = Navigation;
        
        if (index === Navigation.homeView && typeof data === "number") {
            swipeView.currentIndex = Math.min(swipeView.currentIndex, Math.max(0, data));
        }
    }
    
    Connections {
        target: Navigation
        onIndexChanged: onNav()
    }
    
    SwipeView {
        id: swipeView
        interactive: true
        clip: true
        anchors.fill: parent
        focus: false
        focusPolicy: Qt.NoFocus
        
        Repeater {
            id: repeater
            model: App.sets

            delegate: EntrySet {
                entrySet: modelData
            }
        }
        
        Item {
            Component.onCompleted: {
                swipeView.currentIndex = 0
            }
            
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Add Set")
                highlighted: true
                onClicked: Navigation.navigate(Navigation.setEditView)
            }
        }
    }
    
    PageIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        currentIndex: swipeView.currentIndex
        count: repeater.count + 1
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:720;width:420}
}
##^##*/
