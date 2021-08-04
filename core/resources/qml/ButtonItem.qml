import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: buttonItem
    width: 60
    height: 60
    anchors.right: parent.right
    anchors.rightMargin: 10
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 10

    property bool isAddButton
    property string buttonText
    property real pointSize

    readonly property alias mouseArea: mouseArea

    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: "#ffa4a2"
        radius: 100

        property alias text: text

        Text {
            id: text
            anchors.centerIn: parent
            text: buttonItem.buttonText
            font.bold: true
            font.pointSize: buttonItem.pointSize
            wrapMode: TextEdit.WordWrap
            horizontalAlignment: Text.AlignHLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            rotateLeftAnimation.start()
            if(buttonItem.isAddButton) {
                userEntry.visible = true
            }
            else {
                userEntry.getInputText()
            }
            rotateRightAnimation.start()
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

    transform: [
        Rotation {
            id: buttonFlip
            origin.x: buttonItem.width / 2
            origin.y: buttonItem.height / 2
            axis { x: 0; y: 1; z: 0 }
            angle: 0
        }
    ]

    ParallelAnimation {
        id: rotateLeftAnimation
        loops: 1
        PropertyAnimation {
            target: buttonFlip
            properties: "angle"
            from: 0
            to: 180
            duration: 2500
        }
        PropertyAnimation {
            target: buttonRect.text
            properties: "scale"
            from: 1
            to: 0
            duration: 2500
        }
    }

    ParallelAnimation {
        id: rotateRightAnimation
        loops: 1
        PropertyAnimation {
            target: buttonFlip
            properties: "angle"
            from: 180
            to: 0
            duration: 2500
        }
        PropertyAnimation {
            target: buttonRect.text
            properties: "scale"
            from: 0
            to: 1
            duration: 2500
        }
    }
}
