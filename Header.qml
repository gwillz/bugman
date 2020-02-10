import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: root
    implicitHeight: 80
    implicitWidth: 520
    
    Rectangle {
        id: headerBg
        color: Theme.colorCloud
        anchors.fill: parent
    }
    
    Button {
        id: backButton
        enabled: !Navigation.isHome
        opacity: enabled ? 1 : 0.3
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        flat: true
        icon.height: 40
        icon.width: 40
        padding: 10
        icon.source: "icons/back.svg"
        onClicked: Navigation.navigate(Navigation.homeView)
    }
    
    Text {
        text: qsTr("Field Assistant")
        anchors.centerIn: parent
        font.pointSize: Theme.fontTitle
    }
    
    Button {
        id: logoButton
        anchors.verticalCenter: parent.verticalCenter
        flat: true
        anchors.right: parent.right
        anchors.rightMargin: 10
        icon.source: "icons/bugman_logo.svg"
        icon.color: Theme.colorBee
        icon.height: 55
        icon.width: 55
        padding: 5
        onClicked: Navigation.navigate(Navigation.aboutView)
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:80;width:520}
}
##^##*/
