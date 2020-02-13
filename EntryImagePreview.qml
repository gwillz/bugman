import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Item {
    id: root
    
    signal closed()
//    signal add(string image)
//    signal remove(string image)
    
    property alias toggleButton: toggleButton.visible
    property alias checked: toggleButton.checked
    
    function close() {
        root.visible = false;
        root.closed();
    }
    
    function open(checked = true) {
        root.visible = true;
        toggleButton.checked = checked;
    }
    
    Connections {
        target: Navigation
        onCloseDialog: root.close()
    }
    
    onEnabledChanged: {
        Navigation.hasDialog = root.visible
    }
    
    visible: false
    enabled: visible
    
    parent: Window.contentItem
    anchors.fill: parent
    
    Button {
        id: exitButton
        flat: true
        highlighted: true
        icon.source: "/icons/cross.svg"
        icon.color: "white"
        x: 10; y: 10
        width: 40
        height: 40
        z: 3
        
        onClicked: root.close()
    }
    
    Button {
        id: toggleButton
        width: 50
        height: 50
        
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 50
        
        flat: true
        checkable: true
        
        icon.source: checked ? "/icons/tick.svg" : ""
        icon.color: "white"
        z: 3
        
        background: Rectangle {
            anchors.fill: parent
            color: checked ? Theme.colorBee : "transparent"
            radius: 25
            border.width: 3
            border.color: Theme.colorBee
        }
    }
}

