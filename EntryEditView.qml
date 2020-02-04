import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.0
import Qt.labs.platform 1.0

Item {
    id: element
    implicitHeight: 720
    implicitWidth: 420
    
    signal nav(int index)
    
    property int navIndex
    
    onNavIndexChanged: {
        if (navIndex !== Views.entryEdit) {
            fileDialog.close()
        }
    }
    
    ColumnLayout {
        spacing: 10
        anchors.fill: parent
        
        Text {
            id: title
            text: qsTr("Create Entry")
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
                }
                
                EntryField {
                    id: datetimeField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Date & Time *")
                    text: Qt.formatDateTime(new Date(), "dd/MM/yyyy HH:mm")
                    readOnly: true
                }
                
                EntryField {
                    id: positionField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Position *")
                    readOnly: true
                }
                
                EntryField {
                    id: collectorField
                    anchors.right: parent.right
                    anchors.left: parent.left
                    label: qsTr("Collector *")
                    placeholder: qsTr("N. A. Thornberry")
                }
                
                Rectangle {
                    color: "transparent"
                    anchors.right: parent.right
                    anchors.left: parent.left
                    height: 15
                }
            }
            
            footer: Column {
                id: footer
                spacing: 10
                
                Text {
                    text: qsTr("Images")
                    topPadding: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 30
                    font.pointSize: Fonts.body
                }
                
                Row {
                    id: imageField
                    spacing: 10
                    
                    LouButton {
                        id: imagesButton
                        text: qsTr("Add Images")
                        onClicked: fileDialog.open()
                    }
                    
                    Text {
                        id: imagesText
                        text: "0 Images"
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: Fonts.small
                        height: imagesButton.height
                    }
                }
            }
            
            delegate: EntryField {
                anchors.right: parent.right
                anchors.left: parent.left
                label: name
                text: value || ""
            }
            
            model: EntryFieldModel {}
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
        id: fileDialog
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:720;width:420}
}
##^##*/
