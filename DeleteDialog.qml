import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Dialog {
    id: dialog
    modal: true
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    padding: 10
    
    implicitWidth: Math.max(
        header.implicitWidth,
        leftPadding + contentItem.implicitWidth + rightPadding,
        footer.implicitWidth)
    
    Timer {
        interval: 500
        running: true
        repeat: false
        onTriggered: {
            deleteButton.enabled = true
        }
    }
    
    header: Text {
        text: qsTr("Delete Entry")
        padding: 10
        font.pointSize: Fonts.subtitle
    }
    
    background: Rectangle {
        color: Colors.putty
    }
    
    footer: DialogButtonBox {
        spacing: 10
        background: Rectangle { color: "transparent" }
        
        LouButton {
            id: deleteButton
            text: qsTr("Delete")
            highlighted: true
            enabled: false
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        LouButton {
            id: cancelButton
            text: qsTr("Wait no!")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
    }
    
    Text {
        text: qsTr("Delete X, are you sure?")
        font.pointSize: Fonts.body
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
