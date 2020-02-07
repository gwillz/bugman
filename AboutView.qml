import QtQuick 2.12

Item {
    id: element
    
    property Navigation nav
    
    Text {
        text: "About"
        font.pointSize: Theme.subtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
