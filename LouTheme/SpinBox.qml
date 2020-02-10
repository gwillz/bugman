import QtQuick 2.14
import QtQuick.Templates 2.14 as T

T.SpinBox {
    id: control
    
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + leftPadding + rightPadding +
                            up.implicitIndicatorWidth +
                            down.implicitIndicatorWidth)
    implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight,
                             up.implicitIndicatorHeight,
                             down.implicitIndicatorHeight)
    
    spacing: 6
    padding: 6
    leftPadding: 30
    rightPadding: padding + down.indicator.width  + up.indicator.width + spacing
    
    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }
    
    font.pointSize: Theme.body
    
    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)
        
        font: control.font
        color: Theme.text
        selectionColor: Theme.bee
        selectedTextColor: "white"
        
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
        
    }

    up.indicator: Rectangle {
        x: parent.width - width
        implicitHeight: 40
        height: parent.height
        width: height
        color: control.up.pressed ? Theme.bee : Theme.cloud
        radius: 5

        Text {
            text: "+"
            font: control.font
            color: enabled ? Theme.text : Theme.brick
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    
    down.indicator: Rectangle {
        x: parent.width - width * 2
        implicitHeight: 40
        height: parent.height
        width: height
        color: control.down.pressed ? Theme.bee : Theme.cloud
        radius: 5
        
        Text {
            text: "-"
            font: control.font
            color: enabled ? Theme.text : Theme.brick
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    
    background: Rectangle {
        implicitWidth: 160
        implicitHeight: 40
        color: Theme.cloud
        radius: 5
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
