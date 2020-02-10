import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    property string name
    property string set_id
    
    function onExport() {
        const path = App.exportSet(fileNameField.text, root.set_id)
        if (path) {
            dialog.path = path
            dialog.open()
        }
    }
    
    function onNav() {
        const {index, data} = Navigation;
        if (index === Navigation.setSaveView) {
            root.name = data.name;
            root.set_id = data.set_id;
        }
    }
    
    Connections {
        target: Navigation
        onIndexChanged: onNav()
    }
    
    Column {
        spacing: 15
        anchors.fill: parent
        
        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 80
            
            Text {
                text: qsTr("Export: %1").arg(root.name)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 10
                font.pointSize: Theme.fontSubtitle
            }
        }
        
        StringField {
            id: fileNameField
            anchors.left: parent.left
            anchors.right: parent.right
            
            label: qsTr("File name")
            placeholder: root.name + ".csv"
            
            Binding on text {
                property: "text"
                value: root.name + ".csv"
            }
        }
        
        Button {
            text: qsTr("Export")
            highlighted: true
            anchors.left: parent.left
            anchors.leftMargin: 30
            
            onClicked: onExport()
        }
    }
    
    Dialog {
        id: dialog
        title: qsTr("Exported %1").arg(name)
        
        property string path
        
        width: 320
        standardButtons: Dialog.Ok
        
        Connections {
            target: Navigation
            function onCloseDialog() {
                if (dialog.visible) dialog.reject();
                else dialog.close();
            }
        }
        
        onVisibleChanged: {
            Navigation.hasDialog = dialog.visible
        }
        
        Text {
            id: content
            text: qsTr("File saved as: \"%1\"").arg(dialog.path)
            elide: Text.ElideRight
            font.pointSize: Theme.fontBody
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            width: parent.width
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
