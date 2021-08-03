import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: mainWindow
    visible: true
    anchors.fill: parent

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

        model: modelInterface.taskModel

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

        delegate: Rectangle {
            id: taskItem
            width: taskList.width
            height: taskList.height * 0.06
            color: "#ffcdd2"

            Rectangle {
                id: taskState
                width: 20
                height: 20
                anchors.verticalCenter: taskDescription.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                border.color: "#af4448"
                border.width: 2

                Image {
                    id: checkImage
                    source: "marked.png"
                    visible: model.isFinished
                    sourceSize.width: parent.width * 0.75
                    sourceSize.height: parent.height * 0.7
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectCrop
                }

                MouseArea {
                    id: changeStateArea
                    anchors.fill: parent
                    onClicked: model.isFinished = !model.isFinished
                }
            }

            Item {
                id: taskDescription
                width: parent.width - taskState.width - deleteImage.width
                height: parent.height
                anchors.left: taskState.right
                anchors.leftMargin: 10
                anchors.right: deleteImage.left
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                clip: true

                property bool isEditMode: false
                property string previousDescription: model.description

                TextInput {
                    id: textEdit
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.description
                    color: "#af4448"
                    font.bold: true
                    font.pointSize: 18
                    focus: taskDescription.isEditMode

                    onAccepted: {
                        taskDescription.isEditMode = false
                        if(text == "") {
                            text = taskDescription.previousDescription
                        }
                        model.description = text
                    }
                }

                Rectangle {
                    id: crossRect
                    width: taskDescription.width
                    height: 2
                    visible: model.isFinished
                    anchors.centerIn: textEdit
                    color: "black"
                }

                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        taskDescription.forceActiveFocus()
                        taskDescription.isEditMode = true
                    }
                }
            }

            Image {
                id: deleteImage
                source: "delete.png"
                sourceSize.width: 35
                sourceSize.height: 35
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                fillMode: Image.PreserveAspectCrop

                MouseArea {
                    id: deleteArea
                    anchors.fill: parent
                    onClicked: modelInterface.taskModel.removeTask(model.index)
                }
            }
        }

        add: Transition {
            ParallelAnimation {
                NumberAnimation { property: "scale"; from: 0; to: 1; duration: 500 }
                NumberAnimation { properties: "y"; duration: 500 }
            }
        }

        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 1000 }
                NumberAnimation { properties: "x"; to: -100; duration: 1000 }
            }
        }

        removeDisplaced: Transition {
            NumberAnimation { properties: "y"; duration: 1000 }
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
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: userEntryText
            anchors.top: userEntry.top
            anchors.topMargin: 10
            anchors.left: userEntry.left
            anchors.leftMargin: 10
            color: "#af4448"
            font.bold: true
            font.pointSize: 20
            text: "Enter task description"
        }

        TextInput {
            id: textInput
            anchors.top: userEntryText.bottom
            anchors.left: userEntry.left
            anchors.leftMargin: 10
            color: "#e57373"
            font.bold: true
            font.pointSize: 14
            focus: userEntry.visible

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
