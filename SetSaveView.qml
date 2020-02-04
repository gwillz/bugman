import QtQuick 2.12

Item {
    id: root
    implicitHeight: 900
    implicitWidth: 520
    
    signal nav(int index)
    
    Text {
        text: "Export"
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
