import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import QtQuick.Window 2.13

import "EntryModel.js" as EntryModel

ColumnLayout {
    property var entrySet: EntryModel.data[index]
    
    Item {
        id: element
        Layout.rightMargin: 10
        Layout.leftMargin: 10
        Layout.fillWidth: true
        implicitHeight: Math.max(title.height, editButton.height)
        
        Text {
            id: title
            text: entrySet.name
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: Fonts.subtitle
        }
        
        Button {
            id: editButton
            anchors.right: parent.right
            flat: true
            icon.source: "icons/pencil.svg"
            width: height
            onClicked: root.nav(Views.setEdit)
        }
    }
    
    ListView {
        id: listView
        Layout.margins: 10
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: -45
        clip: true
        
        model: entrySet.entries
        
        delegate: EntryBlock {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            onNav: root.nav(index)
            model: entrySet.entries[index]
        }
    }
}
