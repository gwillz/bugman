import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Dialog {
    id: editDialog
    modal: true
    
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    onDiscarded: this.close()
    
    //        standardButtons: Dialog.Save | Dialog.Discard
    
    //        onAccepted: console.log("Hurrah")
    //        onRejected: console.log("Oh no")
    
    header: Rectangle {
        id: rectangle
        color: "#f7f7f2"
        implicitHeight: editDialogTitle.height
        
        Text {
            id: editDialogTitle
            text: qsTr("Edit")
            leftPadding: 40
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.weight: Font.bold
            font.pointSize: 20
        }
    }
    
    background: Rectangle { color: "#f7f7f2" }
    
    footer: DialogButtonBox {
        background: Rectangle { color: "#f7f7f2" }
        Button {
            text: qsTr("Save")
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        Button {
            text: qsTr("Delete")
            DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
        }
        Button {
            text: qsTr("Close")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
    }
    
    Column {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 15
        
        EntryField {
            label: qsTr("Field name")
            placeholder: "..."
            anchors.right: parent.right
            anchors.left: parent.left
        }
        
        EntryField {
            label: qsTr("Field type")
            placeholder: "string"
            anchors.right: parent.right
            anchors.left: parent.left
        }
    }
}
