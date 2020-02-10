import QtQuick 2.14
import QtQuick.Templates 2.14 as T
import QtQuick.Window 2.14

T.TextArea {
    id: control
    
    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)
    
    padding: 6
    leftPadding: 30
    
    font.pointSize: Theme.body
    color: Theme.text
    selectionColor: Theme.bee
    selectedTextColor: "white"
    placeholderTextColor: Theme.brick
    verticalAlignment: TextInput.AlignTop
    
    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)
        
        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
    }
    
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: control.font.pixelSize * 3
        radius: 5
        color: Theme.cloud
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
