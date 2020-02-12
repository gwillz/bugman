import QtQuick 2.0

Item {
    id: root
    
    property string source
    property var overlay
    property bool fullscreen: false
    
    function open() {
        if (!overlay) return;
        
        root.fullscreen = true;
        overlay.visible = true;
        overlay.onClosed.connect(() => {
            root.fullscreen = false;
        });
    }
    
    Image {
        id: image
        source: root.source
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.open()
        }
        
        states: [
            State {
                when: root.fullscreen
                ParentChange {
                    target: image
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
                    target: image
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
    }
}
