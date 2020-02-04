import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import QtPositioning 5.12

Item {
    id: root
    implicitHeight: 720
    implicitWidth: 420
    
    property Navigation nav
    
    onNavChanged: {
        if (nav.index !== Views.entryEdit) {
            imageDialog.close()
        }
    }
    
    PositionSource {
        id: gps
    }
    
    readonly property var location: nav.data.position || gps.position.coordinate
    
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        
        Text {
            id: title
            text: nav.data.voucher ? qsTr("Edit %1").arg(nav.data.voucher) : qsTr("Create Entry")
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
                
                EntryField {
                    id: voucherField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Voucher *")
                    placeholder: "NAT01R001"
                    text: nav.data.voucher || nav.data.next_voucher || ""
                }
                
                EntryField {
                    id: datetimeField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Date & Time *")
                    readOnly: true
                    text: Qt.formatDateTime(nav.data.timestamp
                                            ? new Date(nav.data.timestamp)
                                            : new Date(),
                                            "dd/MM/yyyy HH:mm")
                }
                
                EntryField {
                    id: positionField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Position *")
                    readOnly: true
                    text: qsTr("%1, %2 @ %3m")
                        .arg(location.latitude)
                        .arg(location.longitude)
                        .arg(location.altitude)
                }
                
                EntryField {
                    id: collectorField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Collector *")
                    placeholder: qsTr("N. A. Thornberry")
                    text: nav.data.collector || ""
                }
                
                Rectangle {
                    color: "transparent"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 1
                }
            }
            
            model: nav.data.data || nav.data.fields || ([])
            
            delegate: EntryField {
                anchors.right: parent.right
                anchors.left: parent.left
                label: modelData.name || "???"
                text: modelData.value || ""
                type: modelData.type || "string"
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
                    font.pointSize: Fonts.body
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
                            color: Colors.cloud
                        }
                        text: "Add"
                        display: AbstractButton.IconOnly
                        icon.source: "icons/plus.svg"
                        icon.color: Colors.brick
                        width: grid.itemWidth
                        height: width
                        icon.width: width / 2
                        icon.height: width / 2
                        onClicked: imageDialog.open()
                    }
                    
                    Repeater {
                        model: nav.data.images
                        delegate: Rectangle {
                            color: "#fff"
                            width: grid.itemWidth
                            height: width
                        }
                    }
                }
            }
        }
        
        RowLayout {
            id: buttons
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            
            LouButton {
                id: createButton
                text: qsTr("Create")
                highlighted: true
            }
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
