import QtQuick 2.12
import QtQuick.Controls 2.13
import AppData 1.0

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    property Navigation nav
    
    onNavChanged: {
        nav.onIndexChanged.connect(() => {
            if (nav.index === Views.home &&
                nav.data.index !== undefined) {
                swipeView.currentIndex = nav.data.index || 0;
            }
        })
    }
    
    SwipeView {
        id: swipeView
        clip: true
        focusPolicy: Qt.NoFocus
        anchors.fill: parent
        
        Repeater {
            id: repeater
            model: AppData.sets
            
            delegate: EntrySet {
                entrySet: modelData
                nav: root.nav
            }
        }
        
        Item {
            Component.onCompleted: {
                swipeView.currentIndex = 0
            }
            
            LouButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Add Set")
                focusPolicy: Qt.NoFocus
                highlighted: true
                onClicked: nav.navigate(Views.setEdit)
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
