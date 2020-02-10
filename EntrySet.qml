import QtQuick 2.12
import QtQuick.Controls 2.13

import "EntryModel.js" as EntryModel

Item {
    id: root
    
    property var entrySet: EntryModel.data[0]
    
    implicitWidth: 520
    implicitHeight: 600
    
    Item {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        
        implicitHeight: Math.max(title.height, buttons.height)
        
        Text {
            id: title
            text: entrySet.name || "??"
            font.pointSize: Theme.subtitle
        }
        
        Row {
            id: buttons
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            
            Button {
                id: addButton
                flat: true
                icon.source: "icons/plus.svg"
                onClicked: Navigation.navigate(Navigation.entryEditView, entrySet)
            }
            
            Button {
                id: saveButton
                flat: true
                icon.source: "icons/download.svg"
                onClicked: Navigation.navigate(Navigation.setSaveView, entrySet)
            }
            
            Button {
                id: editButton
                flat: true
                icon.source: "icons/pencil.svg"
                onClicked: Navigation.navigate(Navigation.setEditView, entrySet)
            }
            
            Button {
                id: deleteButton
                flat: true
                icon.source: "icons/trash.svg"
                onClicked: deleteDialog.open()
            }
        }
    }
    
    ListView {
        id: listView
        topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        
        spacing: -45
        clip: true
        
        model: entrySet.entries
        
        delegate: EntryBlock {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            entry: modelData
        }
    }
    
    Button {
        anchors.centerIn: parent
        visible: entrySet.entries.length === 0
        text: qsTr("Add Entry")
        highlighted: true
        onClicked: Navigation.navigate(Navigation.entryEditView, entrySet)
    }
    
    DeleteDialog {
        id: deleteDialog
        title: "Delete Set"
        target: entrySet.name
        
        onAccepted: {
            App.removeSet(entrySet.set_id)
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
