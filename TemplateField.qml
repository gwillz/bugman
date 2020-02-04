import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Rectangle {
    id: content
    
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    
    anchors {
    }
    
    height: wrapper.implicitHeight + 20
    border.width: 0
    radius: 5
    
    color: dragArea.held ? "lightsteelblue" : "#f9f7f2"
    Behavior on color {
        ColorAnimation { duration: 100 }
    }
    
    states: [
        State {
            when: dragArea.held
            
            ParentChange {
                target: content
                parent: root
            }
            
            AnchorChanges {
                target: content
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]
    
    Item {
        id: wrapper
        anchors.fill: parent
        anchors.margins: 10
        
        implicitHeight: column.height
        
        Column {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            
            
            Text {
                text: name
                font.pointSize: 16
            }
            Text {
                text: type
                font.pointSize: 12
            }
        }
    }
}
