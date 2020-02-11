import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import QtMultimedia 5.14
import AndroidFilter 1.0

Item {
    id: root
    
    implicitHeight: 700
    implicitWidth: 420
    
    property bool fullscreen: false
    property var preview: null
    
    function close() {
        root.fullscreen = false
        root.reject();
    }
    
    function reject() {
        if (root.preview) {
            const path = camera.imageCapture.capturedImagePath;
            console.log("delete", path);
            App.removeFile(path);
        }
        root.preview = null;
        timer.stop();
        camera.unlock();
    }
    
    function capture() {
        console.log("snap: capture");
        camera.imageCapture.cancelCapture();
        camera.imageCapture.captureToLocation(App.imagePath);
    }
    
    AndroidFilter {
        id: androidFilter
    }
    
    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage
        position: Camera.BackFace
        focus.focusMode: CameraFocus.FocusAuto
        focus.focusPointMode: CameraFocus.FocusPointCenter
        
        onLockStatusChanged: {
            if (lockStatus === Camera.Locked) {
                console.log("camera locked")
                root.capture()
            }
            else if (lockStatus === Camera.Searching) {
                console.log("camera searching")
            }
            else {
                console.log("camera unlocked")
            }
        }
        
        imageCapture.onImageCaptured: {
            root.preview = preview;
            camera.unlock();
        }
    }
    
    Timer {
        id: timer
        interval: 600
        running: false
        repeat: false
        onTriggered: {
            if (camera.lockStatus === Camera.Unlocked) {
                capture();
            }
        }
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
            z: 3
            
            onClicked: close()
        }
        
        Image {
            id: previewImage
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            visible: !!preview
            source: preview || ""
            z: 2
        }
        
        Row {
            id: row
            anchors.bottomMargin: parent.width * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            spacing: parent.width * 0.4
            visible: !!preview
            z: 3
            
            Button {
                id: acceptButton
                icon.source: "/icons/tick.svg"
                icon.color: "white"
                width: 50
                height: 50
                
                background: Rectangle {
                    anchors.fill: parent
                    color: Theme.colorBee
                    radius: 25
                }
                
                onClicked: { preview = null }
            }
            
            Button {
                id: rejectButton
                icon.source: "/icons/cross.svg"
                icon.color: "white"
                width: 50
                height: 50
                
                background: Rectangle {
                    anchors.fill: parent
                    color: Theme.colorBrick
                    radius: 25
                }
                
                onClicked: root.reject()
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
                else if (!timer.running && camera.lockStatus === Camera.Unlocked) {
                    console.log("snap: init");
                    timer.start();
                    camera.searchAndLock();
                }
                else {
                    console.log("snap: force");
                    timer.stop();
                    camera.unlock();
                    root.capture();
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
