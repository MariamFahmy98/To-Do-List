import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Item {
    id: mainWindow
    visible: true
    width: 640
    height: 900

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

    ButtonItem {
        id: addButton
        visible: !userEntry.visible
        isAddButton: true
        buttonText: "+"
        pointSize: 24
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

        ButtonItem {
            id: doneButton
            isAddButton: false
            buttonText: "Done"
            pointSize: 14
        }

        function getInputText() {
            modelInterface.taskModel.insertNewTask(textInput.text)
            textInput.clear()
            userEntry.visible = false
        }
    }
}
