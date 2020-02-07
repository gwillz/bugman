import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtPositioning 5.12
import AppData 1.0

Item {
    id: root
    implicitHeight: 720
    implicitWidth: 420
    
    property Navigation nav
    
    property int entry_id
    property int entry_set_id
    property string voucher
    property var position: ({})
    property string timestamp
    property string collector
    property var images
    property var fields
    
    onNavChanged: {
        nav.onIndexChanged.connect(() => {
            if (nav.index === Views.entryEdit) {
               root.entry_id = nav.data.entry_id || AppData.nextEntryId()
               root.entry_set_id = nav.data.entry_set_id || nav.data.set_id || 0;
               root.voucher = nav.data.getNextVoucher
                   ? nav.data.getNextVoucher()
                   : (nav.data.voucher || "")
               root.timestamp = nav.data.timestamp || +new Date() + ""
               root.position = nav.data.position || gps.position.coordinate;
               root.collector = nav.data.collector || "";
               root.images = nav.data.images || [];
               root.fields = nav.data.fields || [];
            }
        })
    }
    
    PositionSource {
        id: gps
        active: true
    }
    
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        
        Text {
            id: title
            text: nav.data.entry_id
                  ? qsTr("Edit %1").arg(nav.data.voucher) 
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
                
                LouField {
                    id: voucherField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Voucher *")
                    placeholder: "NAT01R001"
                    text: voucher
                    onTextChanged: voucher = text
                }
                
                LouField {
                    id: datetimeField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Date & Time *")
                    readOnly: true
                    text: Qt.formatDateTime(new Date(+timestamp), "dd/MM/yyyy HH:mm")
                }
                
                LouField {
                    id: positionField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Position *")
                    readOnly: true
                    text: qsTr("%1, %2 @ %3m")
                        .arg(position.latitude.toFixed(5))
                        .arg(position.longitude.toFixed(5))
                        .arg(position.altitude.toFixed(0))
                }
                
                LouField {
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
            
            delegate: LouField {
                anchors.right: parent.right
                anchors.left: parent.left
                label: modelData.name
                text: modelData.value
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
                
                Grid{
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
                        text: "Add"
                        display: AbstractButton.IconOnly
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
        
        LouButton {
            id: createButton
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: nav.data.entry_id ? qsTr("Save") : qsTr("Create")
            highlighted: true
            
            onClicked: {
                if (entry_set_id === 0) {
                    console.warn("Missing set_id.");
                    return;
                }
                
                console.log("save entry", entry_id, entry_set_id)
                
                AppData.setEntry({
                    entry_id,
                    entry_set_id,
                    voucher,
                    timestamp,
                    position,
                    collector,
                    images,
                    fields,
                })
                
                nav.navigate(Views.home)
            }
        }
    }
    
    ImagePicker {
        id: imageDialog
        nav: root.nav
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:720;width:420}
}
##^##*/
