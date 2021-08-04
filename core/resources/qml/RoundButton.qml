import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: root

    property alias text: text.text
    property alias font: text.font

    signal mouseClicked()

    implicitWidth: 60
    implicitHeight: 60

    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: mouseArea.containsMouse ? Theme.accentDarkColor : Theme.accentColor
        radius: width / 2
    }

    Text {
        id: text
        anchors.centerIn: parent
        wrapMode: TextEdit.WordWrap
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Theme.textColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: mouseClicked()
    }
}
