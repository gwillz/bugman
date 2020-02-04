import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import QtQuick.Window 2.1

import "EntryModel.js" as EntryModel

Item {
    id: root
    
    property Navigation nav
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
                        onClicked: nav.navigate(Views.entryEdit, entrySet)
                    }
                    
                    Button {
                        id: saveButton
                        flat: true
                        width: height
                        icon.source: "icons/download.svg"
                        onClicked: nav.navigate(Views.setSave, entrySet)
                    }
                    
                    Button {
                        id: editButton
                        flat: true
                        width: height
                        icon.source: "icons/pencil.svg"
                        onClicked: nav.navigate(Views.setEdit, entrySet)
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
                nav: root.nav
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
