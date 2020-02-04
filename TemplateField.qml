import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Rectangle {
    id: root
    
    property string fieldName: "thing"
    property string fieldType: "type"
    property bool highlighted: false
    property bool hovered: false
    
    implicitHeight: wrapper.implicitHeight + 20
    implicitWidth: wrapper.implicitWidth + 20
    border.width: 0
    radius: 5
    
    color: highlighted
        ? Colors.brick
        : hovered
        ? Colors.cloud
        : Colors.putty
    
    Behavior on color {
        ColorAnimation { duration: 100 }
    }
    
    Item {
        id: wrapper
        anchors.fill: parent
        anchors.margins: 10
        
        implicitHeight: column.height
        implicitWidth: column.implicitWidth + 40 + row.width
        
        Column {
            id: column
            anchors.left: parent.left
            anchors.right: row.left
            
            
            Text {
                text: root.fieldName
                font.pointSize: Fonts.body
            }
            Text {
                text: root.fieldType
                font.pointSize: Fonts.small
            }
        }
        
        Row {
            id: row
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            
            Button {
                display: AbstractButton.IconOnly
                flat: true
                text: qsTr("Edit")
                icon.source: "icons/pencil.svg"
                width: height
                onClicked: editDialog.open()
            }
            
            Button {
                display: AbstractButton.IconOnly
                flat: true
                text: qsTr("Delete")
                icon.source: "icons/trash.svg"
                width: height
                onClicked: deleteDialog.open()
            }
        }
    }
    
    TemplateFieldDialog {
        id: editDialog
    }
    
    DeleteDialog {
        id: deleteDialog
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:100;width:640}
}
##^##*/
