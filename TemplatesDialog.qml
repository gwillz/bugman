import QtQuick 2.12
import QtQuick.Controls 2.13

Dialog {
    id: root
    padding: 10
    modal: true
    
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    signal accepted(var template)
    
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
    
    width: 320
    height: parent.height * 0.75
    
    header: Text {
        id: header
        text: qsTr("Templates")
        font.pointSize: Theme.subtitle
        padding: 10
    }
    
    background: Rectangle {
        color: Theme.putty
    }
    
    ListView {
        id: contents
        spacing: 10
        anchors.fill: parent
        clip: true
        
        model: App.templates
        
        delegate: TemplateItem {
            text: modelData.name
            subtext: qsTr("%1 / %2 fields")
                .arg(modelData.author)
                .arg(modelData.fields.length)
            
            anchors.right: parent.right
            anchors.left: parent.left
            
            onClicked: {
                accepted(modelData)
                close()
            }
        }
    }
    
    footer: DialogButtonBox {
        id: footer
        background: Rectangle { color: "transparent" }
        spacing: 10
        visible: true
        
        Button {
            text: qsTr("Close")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
    }
}

