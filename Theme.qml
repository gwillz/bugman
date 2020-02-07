pragma Singleton
import QtQuick 2.0

Item {
    id: colors
    
    readonly property color stone: "#dcd3c9";
    readonly property color putty: "#f1efe9";
    readonly property color cloud: "#f9f7f2";
    readonly property color brick: "#c6bdb6";
    readonly property color bee:   "#d8a619";
    readonly property color text:  "#335259";
    
    readonly property int small: 14;
    readonly property int body: 16;
    readonly property int subtitle: 22;
    readonly property int title: 32;
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
