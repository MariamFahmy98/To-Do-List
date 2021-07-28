import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: buttonItem
    width: 60
    height: 60
    anchors.right: parent.right
    anchors.rightMargin: parent.width * 0.01
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.width * 0.01

    property bool isAddButton
    property string buttonText
    property real pointSize

    Rectangle {
        id: buttonRect
        anchors.fill: parent
        border.width: buttonItem.width * 0.01
        color: "#ffa4a2"
        radius: 100

        Text {
            id: text
            anchors.centerIn: parent
            text: buttonItem.buttonText
            font.bold: true
            font.pointSize: buttonItem.pointSize
            wrapMode: TextEdit.WordWrap
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                if(buttonItem.isAddButton) {
                    userEntry.visible = true
                }
                else {
                    userEntry.getInputText()
                }
            }
        }
    }
}
