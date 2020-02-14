import QtQuick 2.0

Item {
    id: root
    
    signal clicked()
    
    property string source
    property bool checked: false
    
    // Add a checked icon.
    
    Image {
        id: image
        source: root.source
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        
        MouseArea {
            anchors.fill: parent
            onClicked: root.clicked()
        }
    }
}
