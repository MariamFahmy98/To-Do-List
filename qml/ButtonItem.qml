import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: buttonItem
    width: 60
    height: 60
    anchors.right: parent.right
    anchors.rightMargin: 5
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 5

    property bool isAddButton
    property string buttonText
    property real pointSize

    readonly property alias mouseArea: mouseArea

    Rectangle {
        id: buttonRect
        anchors.fill: parent
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
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if(buttonItem.isAddButton) {
                userEntry.visible = true
                doneButtonAnim.start()
            }
            else {
                addButtonAnim.start()
                userEntry.getInputText()
            }
        }
    }

    states: [
        State {
            name: "Hovered"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: buttonRect
                scale: 1.2
            }
        }
    ]
}
