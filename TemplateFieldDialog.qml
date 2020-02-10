import QtQuick 2.12
import QtQuick.Controls 2.13

Dialog {
    id: root
    
    property string name: ""
    property string type: ""
    
    Connections {
        target: Navigation
        function onCloseDialog() {
            if (root.visible) root.reject();
            else root.close();
        }
    }
    
    onVisibleChanged: {
        Navigation.hasDialog = root.visible
    }
    
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
        
        StringField {
            id: nameEdit
            label: qsTr("Name")
            placeholder: "..."
            anchors.right: parent.right
            anchors.left: parent.left
            text: root.name
            
            Binding {
                target: root
                property: "name"
                value: nameEdit.text
            }
        }
        
        ComboField {
            id: typeEdit
            label: qsTr("Type")
            anchors.right: parent.right
            anchors.left: parent.left
            
            current: root.type
            model: ["string", "integer", "decimal", "switch", "text"]
            
            Binding {
                target: root
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
        
        Button {
            text: qsTr("Save")
            highlighted: true
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        
        Button {
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
