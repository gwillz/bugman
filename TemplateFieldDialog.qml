import QtQuick 2.12
import QtQuick.Controls 2.13

Dialog {
    id: dialog
    padding: 10
    modal: true
    
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    property string name: ""
    property string type: ""
    
    property Navigation nav
    
    onNavChanged: {
        nav.onCloseDialog.connect(() => {
            if (dialog.visible) dialog.reject();
            else dialog.close();
        })
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
        font.pointSize: Theme.subtitle
    }
    
    background: Rectangle {
        color: Theme.putty
    }
    
    Column {
        id: content
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 15
        
        LouField {
            id: nameEdit
            label: qsTr("Name")
            placeholder: "..."
            anchors.right: parent.right
            anchors.left: parent.left
            text: dialog.name
            
            Binding {
                target: dialog
                property: "name"
                value: nameEdit.text
            }
        }
        
        LouComboField {
            id: typeEdit
            label: qsTr("Type")
            anchors.right: parent.right
            anchors.left: parent.left
            
            current: dialog.type
            model: ["string", "integer", "decimal", "text"]
            
            Binding {
                target: dialog
                property: "type"
                value: typeEdit.current
            }
        }
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
    
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
