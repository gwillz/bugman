import QtQuick 2.12
import AppData 1.0

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    property Navigation nav: Navigation {}
    
    Column {
        spacing: 15
        anchors.fill: parent
        
        Item {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 80
            
            Text {
                text: qsTr("Export: %1").arg(nav.data.name)
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                padding: 10
                font.pointSize: Fonts.subtitle
            }
        }
        
        LouField {
            id: fileNameField
            anchors.left: parent.left
            anchors.right: parent.right
            
            label: qsTr("File name")
            placeholder: nav.data.name + ".csv"
            text: nav.data.name + ".csv"
        }
        
        LouButton {
            text: qsTr("Export")
            highlighted: true
            anchors.left: parent.left
            anchors.leftMargin: 30
            
            onClicked: {
                AppData.exportSet(fileNameField.text, nav.data.set_id)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
