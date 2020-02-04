import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Dialog {
    id: dialog
    
    modal: true
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    
    title: qsTr("Delete")
    standardButtons: Dialog.Ok | Dialog.Cancel
    
    onAccepted: console.log("Hurrah")
    onRejected: console.log("Oh no")
    
    Text {
        text: qsTr("Delete X, are you sure?")
    }
}
