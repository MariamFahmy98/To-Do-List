import QtQuick 2.15

ListView {
	id: root
	spacing: 2
	clip: true

	header: Rectangle {
		id: headerArea
		width: root.width
		height: 60
		color: Theme.accentColor
		z: 10

		Text {
			id: headerText
			anchors.centerIn: parent
			font.bold: true
			font.pointSize: 24
			text: "To Do List"
			color: Theme.textColor
		}
	}
	headerPositioning: ListView.OverlayHeader

	delegate: Rectangle {
		id: taskItem
		width: root.width
		height: 50
		color: Theme.accentLightColor

		Rectangle {
			id: taskState
			width: 20
			height: 20
			anchors.verticalCenter: taskDescription.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 10
			border.color: Theme.accentColor
			border.width: 2
			color: changeStateArea.containsMouse ? Theme.accentColor : "transparent"

			Image {
				id: checkImage
				source: "qrc:/icons/marked.png"
				visible: model.isFinished
				anchors.fill: parent
				anchors.margins: 3
				fillMode: Image.PreserveAspectCrop
			}

			MouseArea {
				id: changeStateArea
				anchors.fill: parent
				hoverEnabled: true
				onClicked: model.isFinished = !model.isFinished
			}
		}

		Item {
			id: taskDescription
			height: parent.height
			anchors.left: taskState.right
			anchors.leftMargin: 10
			anchors.right: deleteImage.left
			anchors.rightMargin: 10

			property string previousDescription: model.description

			TextInput {
				id: textEdit
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: parent.left
				anchors.right: parent.right
				text: model.description
				color: Theme.textLightColor
				font.pointSize: 18
				font.strikeout: model.isFinished
				clip: true

				onEditingFinished: {
					textEdit.focus = false
					if(text == "") {
						text = taskDescription.previousDescription
					}
					model.description = text
				}
			}

			MouseArea {
				anchors.fill: parent
				onDoubleClicked: {
					textEdit.forceActiveFocus()
				}
			}
		}

		Image {
			id: deleteImage
			source: "qrc:/icons/delete.png"
			sourceSize.width: 30
			sourceSize.height: 30
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: 10
			fillMode: Image.PreserveAspectCrop

			MouseArea {
				id: deleteArea
				anchors.fill: parent
                onClicked: taskModel.removeTask(model.index)
			}
		}
	}

	add: Transition {
		ParallelAnimation {
			NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
			NumberAnimation { properties: "x"; from: -root.width; duration: 250 }
		}
	}

	remove: Transition {
		ParallelAnimation {
			NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 200 }
			NumberAnimation { properties: "x"; to: width; duration: 250 }
		}
	}

	removeDisplaced: Transition {
		NumberAnimation { properties: "y"; duration: 300 }
	}
}
