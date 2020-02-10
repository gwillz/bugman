import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtGraphicalEffects 1.14

T.Switch {
    id: control
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)
    
    padding: 6
    spacing: 6
    
    contentItem: Label {
        
    }
    
    indicator: Rectangle {
        id: indicator
        color: control.checked ? Theme.colorBee : Theme.colorBrick
        implicitWidth: 46
        implicitHeight: 26
        x: control.leftPadding
        y: control.height / 2 - height / 2
        radius: 14
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        Rectangle {
            y: 3
            x: control.checked ? parent.width - width - y : y
            color: Theme.colorCloud
            radius: 10
            width: 20
            height: 20
            
            Behavior on x {
                PropertyAnimation {
                    easing.type: Easing.OutCirc
                }
            }
            
            Image {
                id: tick
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                anchors.margins: 2
                source: "/icons/tick.svg"
                smooth: true
                visible: false
            }
            
            ColorOverlay {
                anchors.fill: tick
                source: tick
                color: Theme.colorBee
                
                opacity: control.checked ? 1 : 0
                
                Behavior on opacity {
                    PropertyAnimation { duration: 100 }
                }
            }
            
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:100;width:100}D{i:3;anchors_height:20;anchors_width:20}
}
##^##*/
