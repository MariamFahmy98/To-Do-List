import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Window 2.2

Item {
    id: mainWindow
    visible: true
    anchors.fill: parent

    onWidthChanged: {
        if(mainWindow.width < 600) {
            console.log("width")
        }
    }

    onHeightChanged: {
        if(mainWindow.height < 300) {
            console.log("height")
        }
    }

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

            CheckBox {
                id: taskState
                checked: false
                anchors.verticalCenter: taskDescription.verticalCenter
                onToggled: {
                    model.isFinished = checked
                }
            }

            /*Text {
                id: taskDescription
                anchors.left: taskState.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: model.description
                color: "#af4448"
                font.bold: true
                font.pointSize: 18
            }*/

            TextEdit {
                id: taskDescription
                anchors.left: taskState.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                text: model.description
                color: "#af4448"
                font.bold: true
                font.pointSize: 18
            }

            Image {
                id: deleteImage
                source: "delete.png"
                sourceSize.width: 40
                sourceSize.height: 40
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

    SequentialAnimation {
        id: addButtonAnim
        running: false
        loops: 1
        NumberAnimation {
            target: addButton
            property: "rotation"
            from: 0; to: 360
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }

    SequentialAnimation {
        id: doneButtonAnim
        running: false
        loops: 1
        NumberAnimation {
            target: doneButton
            property: "rotation"
            from: 0; to: 360
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }
}
