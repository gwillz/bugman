import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import QtMultimedia 5.14
import AndroidFilter 1.0

Item {
    id: root
    
    property bool fullscreen: false
//    property var position: ({})
    
    function close() {
        root.fullscreen = false
    }
    
    AndroidFilter {
        id: androidFilter
    }
    
    Camera {
        id: camera
        captureMode: Camera.CaptureViewfinder
        position: Camera.BackFace
    }
    
    Item {
        id: overlay
        parent: Window.contentItem
        anchors.fill: parent
        visible: fullscreen
        enabled: visible
        
        Button {
            id: exitButton
            flat: true
            highlighted: true
            icon.source: "/icons/cross.svg"
            icon.color: "white"
            x: 10; y: 10
            width: 40
            height: 40
            z: 2
            
            onClicked: {
                root.fullscreen = false
            }
        }
    }
    
    VideoOutput {
        id: video
        source: camera
        width: parent.width
        height: parent.height
        fillMode: VideoOutput.PreserveAspectCrop
        autoOrientation: true
        filters: [androidFilter]
        
        states: [
            State {
                when: root.fullscreen
                ParentChange {
                    target: video
                    parent: overlay
                    width: parent.width
                    height: parent.height
                    x: 0
                    y: 0
                }
            },
            State {
                when: !root.fullscreen
                ParentChange {
                    target: video
                    parent: root
                    width: parent.width
                    height: parent.height
                }
            }

        ]
        
        transitions: Transition {
            ParentAnimation {
                NumberAnimation {
                    properties: "x,y,width,height"
                    easing.type: Easing.OutCirc
                }
            }
        }
        
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!root.fullscreen) {
                    root.fullscreen = true;
                }
                else {
                    camera.imageCapture.capture()
                }
            }
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
