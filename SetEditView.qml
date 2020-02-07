import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQml.Models 2.14

Item {
    id: root
    
    property var set_id
    property string name
    property string voucher_format
    property string collector
    property bool isEditing: false
    
    Connections {
        target: Navigation
        function onIndexChanged() {
            var {index, data} = Navigation;
            if (index === Navigation.setEditView) {
                root.isEditing = !!data.set_id
                root.set_id = data.set_id || App.nextSetId()
                root.name = data.name  || ""
                root.voucher_format = data.voucher_format || "E%03d"
                root.collector = data.collector || ""
                
                visualModel.model = data.fields || []
            }
        }
    }
    
    implicitWidth: 520
    implicitHeight: 900
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        
        Text {
            text: isEditing
                  ? qsTr("Edit: %1").arg(name)
                  : qsTr("New Set")
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            font.pointSize: Theme.subtitle
        }
        
        ListView {
            id: dragSpace
            bottomMargin: 10
            clip: true
            spacing: 10
            Layout.fillHeight: true
            Layout.fillWidth: true
            
            header: Column {
                id: header
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 15
                
                LouField {
                    id: nameEdit
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Name")
                    placeholder: qsTr("Set One")
                    text: name
                    
                    Binding {
                        target: root
                        property: "name"
                        value: nameEdit.text
                    }
                }
                
                LouField {
                    id: formatEdit
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Voucher Format")
                    placeholder: qsTr("E%03d")
                    text: voucher_format
                    
                    Binding {
                        target: root
                        property: "voucher_format"
                        value: formatEdit.text
                    }
                    
                    Text {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        height: parent.editHeight
                        text: qsTr("\"%1\"").arg(App.sprintf(parent.text, 1))
                        font.pointSize: Theme.small
                        color: Theme.brick
                    }
                }
                
                LouField {
                    id: collectorEdit
                    anchors.left: parent.left
                    anchors.right: parent.right
                    label: qsTr("Collector")
                    placeholder: qsTr("N. A. Thornberry")
                    text: collector
                    
                    Binding {
                        target: root
                        property: "collector"
                        value: collectorEdit.text
                    }
                }
                
                Column {
                    spacing: 10
                    Text {
                        id: fieldLabel
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.right: parent.right
                        font.pointSize: Theme.body
                        text: qsTr("Fields")
                    }
                    
                    Row {
                        spacing: 10
                        
                        LouButton {
                            id: addButton
                            text: qsTr("Add")
                            onClicked: fieldDialog.open()
                        }
                        
                        LouButton {
                            id: templateButton
                            text: qsTr("Load")
                            onClicked: templatesDialog.open()
                        }
                    }
                }
                
                Item { height: 1; width: parent.width }
            }
            
            model: visualModel
            delegate: dragDelegate
        }
        
        LouButton {
            id: saveButton
            
            highlighted: true
            text: isEditing ? qsTr("Save") : qsTr("Create")
            onClicked: {
                console.log("save set", set_id)
                
                const fields = [];
                
                for (let i = 0; i < visualModel.count; i++) {
                    let item = visualModel.items.get(i);
                    fields.push(item.model.modelData);
                }
                
                var index = App.setSet({
                    set_id,
                    name,
                    voucher_format,
                    collector,
                    fields,
                });
                
                Navigation.navigate(Navigation.homeView, { index });
            }
        }
    }
    
    DelegateModel {
       id: visualModel
       model: Navigation.data.fields || []
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
                
                name: modelData.name
                type: modelData.type
                
                onEdited: {
                    var index = parent.DelegateModel.itemsIndex;
                    modelData.name = name
                    modelData.type = type
                }
                
                onRemove: {
                    var index = parent.DelegateModel.itemsIndex;
                    visualModel.items.remove(index);
                }
                
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
                    var from = drag.source.DelegateModel.itemsIndex;
                    var to = dragArea.DelegateModel.itemsIndex;
                    visualModel.items.move(from, to);
                }
            }
        }
    }
    
    TemplateFieldDialog {
        id: fieldDialog
        
        onAccepted: {
            visualModel.model = visualModel.model.concat([{name, type}])
//            visualModel.items.create(0, {modelData: {name, type}});
            name = ""
            type = ""
        }
        
        onRejected: {
            name = ""
            type = ""
        }
    }
    
    TemplatesDialog {
        id: templatesDialog
        
        onAccepted: {
            visualModel.model = template.fields
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
