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

        delegate: Rectangle {
            id: taskItem
            width: taskList.width
            height: taskList.height * 0.06
            color: "#ffcdd2"

            property int index: index

            CheckBox {
                id: taskState
                checked: isFinished
                anchors.verticalCenter: text.verticalCenter
            }

            Text {
                id: taskDescription
                anchors.left: taskState.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: description
                color: "#af4448"
                font.bold: true
                font.pointSize: 18
            }

            Image {
                id: deleteImage
                source: "delete.png"
                sourceSize.width: parent.width * 0.06
                sourceSize.height: parent.height * 0.6
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                fillMode: Image.PreserveAspectCrop

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    onClicked: modelInterface.taskModel.removeTask(taskItem.index)
                }
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
            userEntry.visible = false
            if(textInput.text == "") return;
            modelInterface.taskModel.insertNewTask(textInput.text)
            textInput.clear()
        }
    }
}
