import QtQuick 2.12
import QtQuick.Controls 2.13

Item {
    id: root
    implicitWidth: 200
    implicitHeight: labelText.height + editHeight + 5
    height: implicitHeight
    
    property string label: "Label"
    property string placeholder: "..."
    property string type: "string"
    property alias text: stringField.text
    property alias readOnly: stringField.readOnly
    readonly property int editHeight:
        stringField.visible ? stringField.height
        : intField.visible ? intField.height
        : realField.visible ? realField.height
        : textField.visible ? textField.height
        : listField.visible && listField.height
    
    Text {
        id: labelText
        text: root.label
        anchors.left: parent.left
        anchors.leftMargin: 30
        font.pointSize: Theme.body
    }
    
    TextField {
        id: stringField
        visible: type === "string"
        enabled: visible
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        leftPadding: 30
//        text: root.text
//        onTextChanged: root.text = text
        
        placeholderText: placeholder
        font.pointSize: Theme.body
        
        background: Rectangle {
            radius: 5
            color: Theme.cloud
        }
    }
    
    SpinBox {
        id: intField
        visible: type === "integer"
        enabled: visible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        
        value: +root.text
        onValueChanged: root.text = value + ""
    }
    
    TextField {
        id: realField
        visible: type === "decimal"
        enabled: visible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        leftPadding: 30
        
        text: root.text
        onTextChanged: root.text = text
        font.pointSize: Theme.body
        validator: DoubleValidator {}
        
        background: Rectangle {
            radius: 5
            color: Theme.cloud
        }
    }
    
    TextArea {
        id: textField
        visible: type === "text"
        enabled: visible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        leftPadding: 30
        
        text: root.text
        onTextChanged: root.text = text
        font.pointSize: Theme.body
        height: Math.max(implicitHeight, font.pixelSize * 3)
        
        background: Rectangle {
            radius: 5
            color: Theme.cloud
        }
    }
    
    Switch {
        id: boolField
        visible: type === "switch"
        enabled: visible
        anchors.top: parent.top
        anchors.left: labelText.right
        anchors.leftMargin: 10
        padding: 0
        checked: root.text === "yes"
        onCheckedChanged: root.text = checked ? "yes" : "no"
    }
    
    ComboBox {
        id: listField
        visible: type === "list"
        enabled: visible
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.top: labelText.bottom
        leftPadding: 30
        
        model: ["test", "one", "two", "three"]
        currentIndex: model.indexOf(root.text)
        onCurrentValueChanged: root.text = currentValue
        
        contentItem: Text {
            color: Theme.text
            text: parent.currentText
            bottomPadding: 5
            topPadding: 5
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Theme.body
        }
        
        background: Rectangle {
            radius: 5
            color: Theme.cloud
        }
    }
}

