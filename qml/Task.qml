import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: taskItem
    width: taskList.width
    height: taskList.height * 0.05

    Rectangle {
        id: taskRect
        anchors.fill: parent
        color: "#ffcdd2"
    }
}
