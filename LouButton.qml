import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Button {
    id: root
    Layout.minimumWidth: 100
    implicitWidth: Math.max(contentItem.implicitWidth, 100) + leftPadding + rightPadding
    
    // debug
    text: "Button"
//    enabled: false
//    highlighted: true
    
    contentItem: Text {
        color: root.enabled ? Colors.cloud : Colors.brick
        horizontalAlignment: Text.AlignHCenter
        font: root.font
        text: root.text
    }
    
    background: Rectangle {
        radius: 5
        color: root.enabled
               ? root.highlighted
                    ? Colors.bee
                    : Colors.brick
               : "transparent"
        border {
            width: 2
            color: root.enabled ? "transparent" : palette.button
        }
    }
}
