import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: root
    implicitWidth: 200
    implicitHeight: labelText.height + editHeight + 5
    height: implicitHeight
    
    property string label: field.name
    property string placeholder: "..."
    property bool valid: true
    property alias text: field.text
    property alias readOnly: field.readOnly
    readonly property alias editHeight: field.height
    
    property int leftPadding: 30
    property int rightPadding: 6
    
    Label {
        id: labelText
        text: root.label
        anchors.left: parent.left
        leftPadding: root.leftPadding
    }
    
    TextField {
        id: field
        
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        leftPadding: root.leftPadding
        rightPadding: root.rightPadding + (valid ? 0 : invalid.width + 8)
        
        placeholderText: placeholder
        
        onTextEdited: {
            if (!root.valid) {
                root.valid = !!text
            }
        }
        
        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            radius: 5
            color: Theme.colorCloud
            
            border {
                width: valid ? 0 : 2
                color: Theme.colorBee
            }
        }
    }
    
    Text {
        id: invalid
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.bottom: parent.bottom
        height: field.height
        
        text: qsTr("Invalid")
        verticalAlignment: Text.AlignVCenter
        font.pointSize: Theme.fontSmall
        color: Theme.colorBee
        visible: !valid
    }

}

