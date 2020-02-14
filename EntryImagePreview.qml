import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Item {
    id: root
    
    property var images: ([])
    property var selection: images
    property bool checkable: false
    
    function close() {
        root.y = root.height;
        root.enabled = false;
        root.imagesChanged();
    }
    
    function open(image = "") {
        swipeView.currentIndex = Math.max(0, images.indexOf(image));
        root.enabled = true;
        root.visible = true;
        root.y = 0;
    }
    
    function toggle(image) {
        const index = root.selection.indexOf(image);
        
        if (index >= 0) {
            root.selection.splice(index, 1);
        }
        else {
            root.selection.push(image);
        }
        
        if (root.images.length == 0) {
            root.close();
        }
    }
    
    Connections {
        target: Navigation
        onCloseDialog: root.close()
    }
    
    onEnabledChanged: {
        Navigation.hasDialog = root.enabled
    }
    
    parent: Window.contentItem
    height: parent.height
    width: parent.width
    enabled: false
    visible: false
    y: height
    
    Behavior on y {
        PropertyAnimation {
            easing.type: Easing.OutCirc
        }
    }
    
    Button {
        id: exitButton
        flat: true
        highlighted: true
        icon.source: "/icons/cross.svg"
        icon.color: "white"
        width: 40
        height: 40
        x: 10
        y: 10
        z: 3
        onClicked: root.close()
    }
    
    SwipeView {
        id: swipeView
        anchors.fill: parent
        
        Repeater {
            model: root.images
            
            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                
                sourceComponent: Item {
                    anchors.fill: parent
                    
                    Rectangle {
                        color: "black"
                        anchors.fill: parent
                    }
                    
                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        source: modelData
                    }
                    
                    // Make this an external component.
                    Button {
                        id: toggleButton
                        width: 50
                        height: 50
                        
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.margins: 50
                        
                        flat: true
                        checkable: true
                        visible: root.checkable
                        
                        icon.source: checked ? "/icons/tick.svg" : ""
                        icon.color: "white"
                        z: 3
                        
                        checked: root.selection.indexOf(modelData) >= 0
                        onClicked: root.toggle(modelData)
                        
                        background: Rectangle {
                            anchors.fill: parent
                            color: toggleButton.checked ? Theme.colorBee : "transparent"
                            radius: 25
                            border.width: 3
                            border.color: Theme.colorBee
                        }
                    }
                }
            }
        }
    }
    
    // Page indicator?
}

