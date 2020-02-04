import QtQuick 2.12
import QtQuick.Controls 2.13

Item {
    id: element
    width: 200
    height: 200
    
    Column {
        id: column1
        spacing: 5
        anchors.fill: parent
        
        
        Text {
            text: qsTr("Voucher*")
            anchors.left: parent.left
            anchors.leftMargin: 28
            font.pixelSize: 18
        }
        
        TextField {
            id: textField
            text: qsTr("")
            placeholderText: "X--X--"
            leftPadding: 28
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            font.pointSize: 15
        }
    }
    
}
