import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Item {
    id: root
    signal nav(int index);
    
    implicitWidth: 520
    implicitHeight: 900
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        
        Text {
            text: "Edit set"
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            font.pointSize: Fonts.subtitle
        }
        
        ListView {
            id: dragSpace
            clip: true
            spacing: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            
            model: visualModel
            delegate: dragDelegate
            
            header: Column {
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 15
                
                EntryField {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Name")
                    placeholder: qsTr("Set One")
                }
                
                EntryField {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Format")
                    placeholder: qsTr("S001E%03d")
                }
                
                EntryField {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Collector")
                    placeholder: qsTr("N. A. Thornberry")
                }
                
                Text {
                    id: fieldLabel
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    anchors.right: parent.right
                    font.pointSize: Fonts.body
                    text: qsTr("Fields")
                    bottomPadding: 10
                }
            }
        }
        
        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 10
            
            LouButton {
                id: saveButton
                highlighted: true
                text: qsTr("Create")
            }
            
            LouButton {
                id: addButton
                text: qsTr("Add Field")
                onClicked: fieldDialog.open()
            }
            
            LouButton {
                id: templateButton
                text: qsTr("Load Template")
                onClicked: templatesDialog.open()
            }
        }
    }
    
    DelegateModel {
       id: visualModel
       model: TemplateFieldModel {}
       delegate: dragDelegate
    }
    
    Component {
        id: dragDelegate
        
        MouseArea {
            id: dragArea
            
            property bool held: false
            
            height: field.height
            
            anchors.right: parent.right
            anchors.left: parent.left
            
            drag.target: held ? field : undefined
            drag.axis: Drag.YAxis
            drag.minimumY: parent.y + height / 2 + 10
            drag.maximumY: parent.height - height / 2
            
            onPressAndHold: { held = true }
            onReleased: { held = false }

            
            TemplateField {
                id: field
                
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                Drag.active: dragArea.held
                Drag.source: dragArea
                
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: dragArea.width
                
                highlighted: dragArea.held
                hovered: dragArea.containsMouse
                fieldName: name
                fieldType: type
                
                states: [
                    State {
                        when: dragArea.held
                        
                        ParentChange {
                            target: field
                            parent: root
                        }
                        
                        AnchorChanges {
                            target: field
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
            }
            
            DropArea {
                anchors { fill: parent; margins: 10 }
                
                onEntered: {
                    visualModel.items.move(
                        drag.source.DelegateModel.itemsIndex,
                        dragArea.DelegateModel.itemsIndex)
                }
            }
        }
    }
    
    TemplateFieldDialog {
        id: fieldDialog
    }
    
    TemplatesDialog {
        id: templatesDialog
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:900;width:520}
}
##^##*/
