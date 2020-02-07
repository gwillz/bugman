import QtQuick 2.12
import AppData 1.0

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    property string name
    property string set_id
    
    Connections {
        target: Navigation
        function onIndexChanged() {
            var {index, data} = Navigation;
            if (index === Navigation.saveEditView) {
                root.name = data.name;
                root.set_id = data.set_id;
            }
        }
    }
    
    Column {
        spacing: 15
        anchors.fill: parent
        
        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 80
            
            Text {
                text: qsTr("Export: %1").arg(name)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 10
                font.pointSize: Theme.subtitle
            }
        }
        
        LouField {
            id: fileNameField
            anchors.left: parent.left
            anchors.right: parent.right
            
            label: qsTr("File name")
            placeholder: name + ".csv"
            text: name + ".csv"
        }
        
        LouButton {
            text: qsTr("Export")
            highlighted: true
            anchors.left: parent.left
            anchors.leftMargin: 30
            
            onClicked: {
                AppData.exportSet(fileNameField.text, set_id)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
