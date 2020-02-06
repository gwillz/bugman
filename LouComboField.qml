import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: root
    implicitHeight: labelText.height + editField.height + 5
    implicitWidth: 200
    
    property string label: ""
    property var model: ([])
    property string current: ""
    
    Binding {
        target: root
        when: current !== editField.currentText
        property: "current"
        value: editField.currentText
    }
    
    onModelChanged: {
        if (!current) current = model[0] || "";
    }
    
    Text {
        id: labelText
        text: root.label || "Label*"
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 30
        font.pointSize: Fonts.body
    }
    
    ComboBox {
        id: editField
        anchors.top: labelText.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.left: parent.left
        leftPadding: 30
        
        contentItem: Text {
            color: Colors.text
            text: current
            bottomPadding: 5
            topPadding: 5
            verticalAlignment: Text.AlignVCenter
            font.pointSize: Fonts.body
        }
        
        background: Rectangle {
            radius: 5
            color: Colors.cloud
        }
        
        model: root.model
        currentIndex: Math.max(0, model.indexOf(current))
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:100;width:200}
}
##^##*/
