import QtQuick 2.15

Item {
    id: root

    function getInputText() {
        if(textInput.text == "") return;

        modelInterface.taskModel.insertNewTask(textInput.text)
        textInput.clear()
    }

    Item {
        id: userEntryContainer

        anchors.fill: parent
        visible: false
        opacity: 0

        transform: Translate {
            id: userEntryContainerTranslate
            y: height
        }

        Rectangle {
            id: background
            anchors.fill: parent
            color: Theme.accentLightColor
        }

        Text {
            id: userEntryText
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            color: Theme.textColor
            font.bold: true
            font.pointSize: 20
            text: "Enter task description"
        }

        TextInput {
            id: textInput
            anchors.top: userEntryText.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: doneButton.width + 20
            anchors.leftMargin: 10
            color: Theme.textLightColor
            font.bold: true
            font.pointSize: 14
            clip: true

            onAccepted: {
                root.getInputText()
                root.state = ""
            }
        }
    }

    RoundButton {
        id: doneButton
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        text: "Done"
        visible: false
        font.pointSize: 14
        transform: Rotation{
            id: doneButtonRotation
            origin.x: doneButton.width / 2
            origin.y: doneButton.height / 2
            axis.x: 0
            axis.y: 1
            axis.z: 0
            angle: 180
        }

        onMouseClicked: {
            root.state = ""
            root.getInputText()
        }
    }

    RoundButton {
        id: addButton
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        visible: true
        text: "+"
        font.pointSize: 24
        transform: Rotation{
            id: addButtonRotation
            origin.x: addButton.width / 2
            origin.y: addButton.height / 2
            axis.x: 0
            axis.y: 1
            axis.z: 0
        }

        onMouseClicked: {
            root.state = "newTask"
        }
    }

    states: [
        State {
            name: "newTask"

            PropertyChanges {
                target: addButton
                opacity: 0
                visible: false
            }
            PropertyChanges {
                target: addButtonRotation
                angle: 180
            }

            PropertyChanges {
                target: doneButton
                opacity: 1
                visible: true
            }
            PropertyChanges {
                target: doneButtonRotation
                angle: 0
            }

            PropertyChanges {
                target: userEntryContainer
                visible: true
                opacity: 1
            }
            PropertyChanges {
                target: userEntryContainerTranslate
                y: 0
            }
            PropertyChanges {
                target: textInput
                focus: true
            }
        }
    ]

    transitions: [
        Transition {
            from: ""; to: "newTask"; reversible: true

            NumberAnimation {
                target: addButton
                properties: "opacity, visible"
                duration: 250
            }
            NumberAnimation {
                target: addButtonRotation
                properties: "angle"
                duration: 250
            }

            NumberAnimation {
                target: doneButton
                properties: "opacity, visible"
                duration: 250
            }
            NumberAnimation {
                target: doneButtonRotation
                properties: "angle"
                duration: 250
            }

            NumberAnimation {
                target: userEntryContainer
                properties: "opacity, visible"
                duration: 250
            }
            NumberAnimation {
                target: userEntryContainerTranslate
                properties: "y"
                duration: 250
            }
        }
    ]
}
