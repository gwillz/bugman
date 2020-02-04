import QtQuick 2.12

Item {
    id: element
    
    signal nav(int index);
    
    Text {
        text: "About"
        font.pointSize: Fonts.subtitle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:580;width:320}
}
##^##*/
