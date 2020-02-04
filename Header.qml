import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: header
    //            height: 60
    Layout.fillWidth: true
    Layout.minimumHeight: 60
    
    Rectangle {
        id: headerBg
        color: "#f9f7f2"
        anchors.fill: parent
    }
    
    Button {
        id: backButton
        width: 40
        text: qsTr("Back")
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -40
        anchors.left: parent.left
        anchors.leftMargin: 0
        flat: true
        display: AbstractButton.IconOnly
        icon.source: "icons/back.svg"
        
    }
    
    Image {
        id: logo
        sourceSize.height: 40
        anchors.right: parent.right
        anchors.rightMargin: 0
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        source: "icons/bugman_logo.svg"
    }
    
}
