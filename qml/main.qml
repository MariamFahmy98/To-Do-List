import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Item {
    id: mainWindow
    visible: true
    width: 640
    height: 1000

    Rectangle {
        id: emptySpace
        width: mainWindow.width
        height: mainWindow.height * 0.03
        color: "#af4448"
    }

    ListView {
        id: taskList
        width: mainWindow.width
        height: mainWindow.height - addButton.height
        anchors.top: emptySpace.bottom
        spacing: 5

        header: Rectangle {
            id: headerArea
            width: taskList.width
            height: taskList.height * 0.07
            color: "#e57373"

            Text {
                id: headerText
                anchors.centerIn: parent
                font.bold: true
                font.pointSize: 24
                text: "To Do List"
            }
        }

        model: modelInterface.taskModel

        delegate: Task {
            Text {
                id: testtt
                text: description
                color: "#af4448"
                font.bold: true
                anchors.centerIn: parent
            }
        }

    }

    Rectangle {
        id: addButton
        width: 60
        height: 60
        visible: !userEntry.visible
        border.width: addButton.width * 0.01
        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.01
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.01
        color: "#ffa4a2"
        radius: 100

        Text {
            text: "+"
            anchors.centerIn: parent
            font.bold: true
            font.pointSize: 24
            wrapMode: TextEdit.WordWrap
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                userEntry.visible = true
            }
        }
    }

    Rectangle {
        id: userEntry
        width: mainWindow.width
        height: mainWindow.height * 0.1
        visible: false
        color: "#ffcdd2"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.width * 0.01
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: userEntryText
            anchors.top: userEntry.top
            anchors.topMargin: userEntry.width * 0.01
            color: "#af4448"
            font.bold: true
            font.pointSize: 20
            text: "Enter task description"
        }


        TextInput {
            id: textInput
            anchors.top: userEntryText.bottom
            color: "#e57373"
            font.bold: true
            font.pointSize: 14
            focus: true

            onAccepted: {
                userEntry.getInputText()
            }
        }

        Rectangle {
            id: doneButton
            width: 60
            height: 60
            border.width: addButton.width * 0.01
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.01
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.width * 0.01
            color: "#ffa4a2"
            radius: 100

            Text {
                text: "Done"
                anchors.centerIn: parent
                font.bold: true
                font.pointSize: 14
                wrapMode: TextEdit.WordWrap
            }

            MouseArea {
                id: doneMouseArea
                anchors.fill: parent
                onClicked: {
                    userEntry.getInputText()
                }
            }
        }

        function getInputText() {
            modelInterface.taskModel.insertNewTask(textInput.text)
            textInput.clear()
            userEntry.visible = false
        }
    }
}
