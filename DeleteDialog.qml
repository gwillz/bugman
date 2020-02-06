import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3

Dialog {
    id: root
    modal: true
    parent: Overlay.overlay
    anchors.centerIn: Overlay.overlay
    padding: 10
    
    property Navigation nav
    property string type
    property var target
    
    onNavChanged: {
        nav.onCloseDialog.connect(() => {
            if (root.visible) root.reject();
            else root.close();
        })
    }
    
    onVisibleChanged: {
        if (nav) nav.hasDialog = root.visible
        
        if (root.visible) {
            deleteButton.enabled = false
            timer.start()
        }
    }
    
    implicitWidth: Math.max(header.implicitWidth, 280, footer.implicitWidth)
    
    Timer {
        id: timer
        interval: 800
        running: false
        repeat: false
        onTriggered: {
            deleteButton.enabled = true
        }
    }
    
    header: Text {
        text: qsTr("Delete %1").arg(root.type)
        padding: 10
        font.pointSize: Fonts.subtitle
    }
    
    background: Rectangle {
        color: Colors.putty
    }
    
    footer: DialogButtonBox {
        spacing: 10
        background: Rectangle { color: "transparent" }
        
        LouButton {
            id: deleteButton
            text: qsTr("Delete")
            highlighted: true
            enabled: false
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
        
        LouButton {
            id: cancelButton
            text: qsTr("Wait no!")
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
    }
    
    Text {
        text: qsTr("Delete \"%1\", are you sure?").arg(root.target)
        wrapMode: Text.WordWrap
        font.pointSize: Fonts.body
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
