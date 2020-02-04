import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import QtQuick.Window 2.1

import "EntryModel.js" as EntryModel

Item {
    id: root
    signal nav(int index)
    property var entrySet: EntryModel.data[0]
    
    implicitWidth: 520
    implicitHeight: 600
    
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        
        
        Item {
            id: headers
            height: row.implicitHeight
            Layout.fillWidth: true
            
            RowLayout {
                id: row
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.left: parent.left
                anchors.right: parent.right
                
                Text {
                    id: title
                    text: entrySet.name || "??"
                    font.pointSize: Fonts.subtitle
                }
                
                Row {
                    id: buttons
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    
                    Button {
                        id: addButton
                        flat: true
                        width: height
                        icon.source: "icons/plus.svg"
                        onClicked: root.nav(Views.entryEdit)
                    }
                    
                    Button {
                        id: saveButton
                        flat: true
                        width: height
                        icon.source: "icons/download.svg"
                        onClicked: root.nav(Views.setSave)
                    }
                    
                    Button {
                        id: editButton
                        flat: true
                        width: height
                        icon.source: "icons/pencil.svg"
                        onClicked: root.nav(Views.setEdit)
                    }
                }
            }
            
        }
        
        ListView {
            id: listView
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
                entry: modelData
            }
        }
        
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
