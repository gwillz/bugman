pragma Singleton
import QtQuick 2.0

Item {
    id: views
    
    readonly property int home:      0;
    readonly property int about:     1;
    readonly property int entryEdit: 2;
    readonly property int setEdit:   3;
    readonly property int setSave:   4;
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
