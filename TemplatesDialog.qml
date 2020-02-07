import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14
import AppData 1.0

Dialog {
    id: dialog
    padding: 10
    modal: true
    
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    signal accepted(var template)
    
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
        
        model: AppData.templates
        
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
}

