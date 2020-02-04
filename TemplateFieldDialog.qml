import QtQuick 2.12
import QtQuick.Controls 2.13

Dialog {
    id: dialog
    padding: 10
    modal: true
    
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    property Navigation nav
    
    onNavChanged: {
        nav.onCloseDialog.connect(dialog.reject)
    }
    
    onVisibleChanged: {
        if (nav) nav.hasDialog = dialog.visible
    }
    
    implicitWidth: Math.max(
        header.implicitWidth,
        leftPadding + contentItem.implicitWidth + rightPadding,
        footer.implicitWidth)
    
    header: Text {
        id: header
        text: qsTr("Edit Field")
        padding: 10
        font.pointSize: Fonts.subtitle
    }
    
    background: Rectangle {
        color: Colors.putty
    }
    
    footer: DialogButtonBox {
        id: footer
        background: Rectangle { color: "transparent" }
        spacing: 10
        visible: true
        
        LouButton {
            text: qsTr("Save")
            highlighted: true
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        LouButton {
            text: qsTr("Close")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
    }
    
    Column {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 15
        
        EntryField {
            label: qsTr("Name")
            placeholder: "..."
            anchors.right: parent.right
            anchors.left: parent.left
        }
        
        EntryField {
            label: qsTr("Type")
            placeholder: "string"
            anchors.right: parent.right
            anchors.left: parent.left
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
