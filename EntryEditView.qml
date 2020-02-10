import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtPositioning 5.12

import "EntryModel.js" as EntryModel

Item {
    id: root
    implicitHeight: 720
    implicitWidth: 420
    
    property int entry_id
    property int entry_set_id
    property string voucher
    property var position: ({})
    property string timestamp
    property string collector
    property var images
    property var fields: EntryModel.data[0].entries[0].fields
    
    property bool isEditing: false
    
    function onCreate() {
        if (entry_set_id === 0) {
            console.warn("Missing set_id.");
            return;
        }
        
        console.log("save entry", entry_id, entry_set_id)
        
        // It appears the QCoordinate object is a bit funny.
        const {latitude, longitude, altitude} = position;
        
        const index = App.setEntry({
            entry_id,
            entry_set_id,
            voucher,
            timestamp,
            position: { latitude, longitude, altitude },
            collector,
            images,
            fields,
        })
        
        Navigation.navigate(Navigation.homeView, index)
    }
    
    function onNav() {
        const {index, data} = Navigation;
        
        if (index === Navigation.entryEditView) {
            root.isEditing = !!data.entry_id
            root.entry_id = data.entry_id || App.nextEntryId()
            root.entry_set_id = data.entry_set_id || data.set_id || 0;
            root.voucher = data.getNextVoucher
                ? data.getNextVoucher()
                : (data.voucher || "")
            root.timestamp = data.timestamp || +new Date() + ""
            root.position = data.position || gps.position.coordinate;
            root.collector = data.collector || "";
            root.images = data.images || [];
            root.fields = data.fields || [];
        }
    }
    
    Connections {
        target: Navigation
        onIndexChanged: onNav()
    }
    
    PositionSource {
        id: gps
        
        onPositionChanged: {
            if (!isEditing) {
                root.position = position.coordinate
            }
        }
    }
    
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        
        Text {
            id: title
            text: isEditing
                  ? qsTr("Edit %1").arg(voucher) 
                  : qsTr("New Entry")
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
            padding: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
        }

        ListView {
            id: listView
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 15
            
            header: Column {
                spacing: 15
                anchors.right: parent.right
                anchors.left: parent.left
                
                StringField {
                    id: voucherField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Voucher *")
                    placeholder: "NAT01R001"
                    text: voucher
                    onTextChanged: voucher = text
                }
                
                StringField {
                    id: datetimeField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Date & Time *")
                    readOnly: true
                    text: Qt.formatDateTime(new Date(+timestamp), "dd/MM/yyyy HH:mm")
                }
                
                StringField {
                    id: positionField
                    label: qsTr("Position *")
                    readOnly: true
                    text: qsTr("%1, %2 @ %3m")
                        .arg(position.latitude.toFixed(5))
                        .arg(position.longitude.toFixed(5))
                        .arg(position.altitude.toFixed(0))
                    
                    anchors.right: parent.right
                    anchors.left: parent.left
                    rightPadding: refreshButton.width
                    
                    Button {
                        id: refreshButton
                        
                        display: AbstractButton.IconOnly
                        text: qsTr("Refresh")
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        flat: true
                        implicitWidth: height
                        icon.source: "icons/refresh.svg"
                        onClicked: gps.update()
                    }
                }
                
                StringField {
                    id: collectorField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Collector *")
                    placeholder: qsTr("N. A. Thornberry")
                    text: collector
                    onTextChanged: collector = text
                }
                
                Rectangle {
                    color: "transparent"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 1
                }
            }
            
            model: fields
            
            delegate: EntryField {
                anchors.right: parent.right
                anchors.left: parent.left
                label: modelData.name
                text: modelData.value || ""
                type: modelData.type
                
                onTextChanged: {
                    fields[index].value = text
                }
            }
            
            footer: Column {
                id: footer
                spacing: 10
                anchors.left: parent.left
                anchors.right: parent.right
                
                Text {
                    text: qsTr("Images")
                    topPadding: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    font.pointSize: Theme.body
                }
                
                Grid {
                    id: grid
                    spacing: 10
                    columns: 4
                    
                    anchors.left: parent.left
                    anchors.right: parent.right
                    
                    property int itemWidth: {
                        var spacing = (grid.columns - 1) * grid.spacing;
                        return (grid.width - spacing) / grid.columns;
                    }
                    
                    Button {
                        id: imageButton
                        background: Rectangle {
                            color: Theme.cloud
                        }
                        flat: true
                        icon.source: "icons/plus.svg"
                        icon.color: Theme.brick
                        width: grid.itemWidth
                        height: width
                        icon.width: width / 2
                        icon.height: width / 2
                        onClicked: imageDialog.open()
                    }
                    
                    Repeater {
                        model: images
                        delegate: Rectangle {
                            color: "#fff"
                            width: grid.itemWidth
                            height: width
                        }
                    }
                }
            }
        }
        
        Button {
            id: createButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: isEditing ? qsTr("Save") : qsTr("Create")
            highlighted: true
            
            onClicked: onCreate()
        }
    }
    
    ImagePicker {
        id: imageDialog
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:720;width:420}
}
##^##*/
