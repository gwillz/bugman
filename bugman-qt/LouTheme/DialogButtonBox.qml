
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

T.DialogButtonBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            (control.count === 1 ? implicitContentWidth * 2 : implicitContentWidth) + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    contentWidth: contentItem.contentWidth

    spacing: 10
    padding: 10
    alignment: count === 1 ? Qt.AlignRight : undefined
    
    property int highlight: Dialog.AcceptRole
    
    delegate: Button {
        width: control.count === 1 ? control.availableWidth / 2 : undefined
        highlighted: DialogButtonBox.buttonRole === highlight
    }
    
    contentItem: ListView {
        model: control.contentModel
        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapToItem
    }

    background: Rectangle {
        color: "transparent"
        implicitHeight: 40
        x: 1; y: 1
        width: parent.width - 2
        height: parent.height - 2
    }
}


