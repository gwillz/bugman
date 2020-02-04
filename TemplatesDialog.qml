import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Dialog {
    id: dialog
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
    
    header: Text {
        text: qsTr("Templates")
        font.pointSize: Fonts.subtitle
        padding: 10
    }
    
    ListView {
        anchors.right: parent.right
        anchors.left: parent.left
        
        model: AppData.templates
        
        delegate: TemplateField {
            text: modelData.name
            subtext: qsTr("%1 / %2 fields")
                .arg(modelData.author)
                .arg(modelData.fields.length)
        }
    }
}


