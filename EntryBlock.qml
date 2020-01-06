import QtQuick 2.0

Item {
    id: element
    Rectangle {
        id: rectangle
        x: 0
        color: "#ffffff"
        radius: 10
        anchors.top: parent.top
        anchors.topMargin: 35
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

    Rectangle {
        id: rectangle1
        width: 200
        height: 56
        color: "#ffffff"
        radius: 10
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Text {
            id: element1
            text: qsTr("Text")
            anchors.right: parent.right
            anchors.rightMargin: 12
            clip: false
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.top: parent.top
            anchors.topMargin: 8
            font.pixelSize: 16
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:445;anchors_width:566;anchors_x:38;anchors_y:0}
D{i:3;anchors_x:8;anchors_y:8}D{i:2;anchors_x:0;anchors_y:0}
}
##^##*/
