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
    
    title: qsTr("Edit Field")
    standardButtons: Dialog.Save | Dialog.Close
    
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
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
