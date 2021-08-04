import QtQuick 2.9
import QtQuick.Controls 2.5

Rectangle {
    id: root
    anchors.fill: parent
    color: Theme.primaryColor

    Rectangle {
        id: emptySpace
        width: root.width
        height: 20
        color: Theme.accentDarkColor
    }

    TaskList {
        id: taskList
        width: root.width
        anchors.top: emptySpace.bottom
        anchors.bottom: userEntry.top
        model: modelInterface.taskModel
    }

    UserEntry {
        id: userEntry
        width: root.width
        height: 80
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
