import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.0
import AppData 1.0

import "EntryModel.js" as EntryModel

Frame {
    id: root
    property Navigation nav
    
    // debug
    implicitWidth: 520
//    focus: true
    
    property var entry: EntryModel.data[0].entries[0]
    
    property int offset: root.focus ? 60 : 0
    
    contentHeight: tab.height + body.height + offset
    padding: 0
    
    background: Rectangle { visible: false }
    
    transform: Rotation {
        id: rotation
        angle: root.focus ? 0 : -10
        axis: "1,0,0"
        origin.x: body.width / 2
        
        Behavior on angle {
            PropertyAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
        }
    }
    
    Behavior on offset {
        PropertyAnimation {
            easing.type: Easing.OutCirc
            duration: 300
        }
    }
    
    DropShadow {
        anchors.fill: tab
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10.0
        samples: 17
        color: "#30000000"
        source: tab
    }
    
    DropShadow {
        anchors.fill: body
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10.0
        samples: 17
        color: "#30000000"
        source: body
    }
    
    Item {
        id: tab
        enabled: true
        anchors.top: parent.top
        anchors.left: parent.left
        
        implicitHeight: voucherText.height
        implicitWidth: voucherText.width
        
        MouseArea {
            anchors.fill: parent
            enabled: true
            onClicked: {root.focus = !root.focus}
        }
        
        Rectangle {
            id: tabBg
            color: root.focus ? Colors.cloud : Colors.putty
            radius: 8
            border.width: 0
            anchors.fill: parent
            anchors.bottomMargin: -30
        }
        
        Text {
            id: voucherText
            text: entry.voucher || "??"
            font.weight: Font.Bold
            bottomPadding: 5
            topPadding: 5
            rightPadding: 60
            leftPadding: 10
            anchors.top: parent.top
            font.pixelSize: 20
        }
    }
    
    Item {
        id: body
        clip: true
        anchors.right: parent.right
        anchors.top: tab.bottom
        anchors.left: parent.left
        
        enabled: root.focus
        
        implicitHeight: root.focus
            ? detailBox.height
            : previewBox.height
        
        Behavior on implicitHeight {
            PropertyAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
        }
        
        Rectangle {
            id: bodyBg
            color: root.focus ? Colors.cloud : Colors.putty
            radius: 10
            anchors.fill: parent
            border.color: "#00000000"
            border.width: 0
        }
        
        Text {
            id: previewBox
            text: qsTr("%1 / %2")
                .arg(Qt.formatDateTime(new Date(+entry.timestamp), "dd MMM yyyy / HH:mm"))
                .arg(entry.collector)
            verticalAlignment: Text.AlignTop
            padding: 10
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            font.pointSize: Fonts.small
            height: 100
            
            opacity : root.focus ? 0 : 1
            
            Behavior on opacity {
                PropertyAnimation { duration: 100 }
            }
        }
        
        ColumnLayout {
            id: detailBox
            spacing: 10
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            
            opacity : root.focus ? 1 : 0
            
            Behavior on opacity {
                PropertyAnimation { duration: 100 }
            }
            
            Column {
                id: detailRows
                spacing: 5
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.minimumHeight: 100
                
                EntryItem {
                    name: "Voucher"
                    value: entry.voucher
                }
                
                EntryItem {
                    name: "Date"
                    value: Qt.formatDateTime(new Date(+entry.timestamp), "dd MMM yyyy - HH:mm")
                }
                
                
                EntryItem {
                    name: "Collector"
                    value: entry.collector
                }
                
                EntryItem {
                    name: "Position"
                    value: qsTr("%1, %2 @ %3m")
                        .arg(entry.position.latitude.toFixed(5))
                        .arg(entry.position.longitude.toFixed(5))
                        .arg(entry.position.altitude.toFixed(0))
                }
                
                Repeater {
                    model: entry.fields
                    delegate: EntryItem { item: modelData }
                }
            }
            
            Row {
                id: buttonBox
                Layout.topMargin: 10
                Layout.bottomMargin: 20
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                spacing: 10
                
                Button {
                    id: editButton
                    text: qsTr("Edit")
                    flat: true
                    display: AbstractButton.IconOnly
                    onClicked: nav.navigate(Views.entryEdit, entry)
                    icon.source: "icons/pencil.svg"
                    width: height
                }
                
                Button {
                    id: deleteButton
                    text: qsTr("Delete")
                    flat: true
                    display: AbstractButton.IconOnly
                    onClicked: deleteDialog.open()
                    icon.source: "icons/trash.svg"
                    width: height
                }
            }
        }
    }
    
    DeleteDialog {
        id: deleteDialog
        nav: root.nav
        
        onAccepted: {
            AppData.removeEntry(entry.entry_set_id, entry.entry_id)
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
