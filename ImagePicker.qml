import QtQuick 2.14
import QtQuick.Controls 2.13
import QtMultimedia 5.14
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12

Item {
    id: root
    parent: Overlay.overlay
    anchors.fill: parent
//    implicitWidth: 420
//    implicitHeight: 420
    
    enabled: false
    visible: false
    
    signal accepted()
    signal rejected()
    
    Connections {
        target: Navigation
        function onCloseDialog() {
            root.close()
        }
    }
    
    onEnabledChanged: {
        Navigation.hasDialog = root.enabled
    }
    
    property int offset: flick.height
    
    function open() {
        offset = flick.height - 300
        enabled = true
        visible = true
    }
    
    function close() {
        enabled = false
        offset = flick.height
        flick.contentY = 0
    }
    
    Behavior on offset {
        PropertyAnimation {
            easing.type: Easing.OutCirc
            duration: 200
            
            onFinished: {
                if (!root.enabled) {
                    root.visible = false
                }
            }
        }
    }
    
    Camera {
        id: camera
        captureMode: Camera.CaptureViewfinder
        position: Camera.BackFace
        
//        onAvailabilityChanged: console.log("avaiable", availability)
//        onCameraStateChanged: console.log("state", cameraState)
//        onCameraStatusChanged: console.log("status", cameraStatus)
        onErrorStringChanged: console.log(errorString)
    }
    
    Binding {
        target: header
        property: "y"
        value: Math.max(0, -flick.contentY + offset)
    }
    
    Rectangle {
        id: header
        color: "#fff"
        height: row.height + 20
        width: root.width
        z: 10
        
        Row {
            id: row
            anchors.fill: parent
            anchors.margins: 10
            height: closeButton.height
            spacing: 10
            
            Button {
                id: closeButton
                text: "close"
                flat: true
                display: AbstractButton.IconOnly
                
                icon.source: "icons/back.svg"
                width: height
                
                onClicked: root.close()
            }
            
            Text {
                id: titleText
                text: "Images"
                verticalAlignment: Text.AlignVCenter
                font.pointSize: Theme.body
                height: closeButton.height
            }
        }
    }
    
    Flickable {
        id: flick
        clip: true
        
        flickableDirection: Flickable.VerticalFlick
        height: root.height
        width: root.width
        
        onDragEnded: {
            if (contentY < -50) {
                root.close();
            }
        }
        
        contentHeight: content.implicitHeight
        contentWidth: content.implicitWidth
        
        Rectangle {
            id: content
            color: "#fff"
            implicitHeight: grid.height + header.height + 300
            implicitWidth: flick.width
            y: offset
            
            Grid {
                id: grid
                columns: 4
                columnSpacing: 10
                rowSpacing: 10
                anchors.top: parent.top
                anchors.topMargin: header.height
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.margins: 10
                
                property int itemWidth: {
                    var spacing = (grid.columns - 1) * grid.rowSpacing;
                    return (grid.width - spacing) / grid.columns;
                }
                
                VideoOutput {
                    source: camera
                    visible: false
                    enabled: false
                    clip: true
                    
                    width: grid.itemWidth
                    height: width
                    fillMode: VideoOutput.PreserveAspectCrop
                    autoOrientation: true
                }
                
                Repeater {
                    model: App.images
                    delegate: Image {
                        width: grid.itemWidth
                        height: width
                        source: modelData
                        fillMode: Image.PreserveAspectCrop
                    }
                }
                
//                Repeater {
//                    model: 40
//                    delegate: Rectangle {
//                        color: "#000"
//                        width: grid.itemWidth
//                        height: width
//                    }
//                }
            }
        }
        
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
