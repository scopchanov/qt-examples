import QtQuick 2.15
import "../cdk"

/*
 * Text Button
 */

Item {
	id: root

	property alias text: label.text

	signal clicked()

	implicitWidth: label.implicitWidth + 16
	implicitHeight: 36
	activeFocusOnTab: true

	Rectangle {
		id: base

		anchors.fill: parent
		color: "transparent"
		radius: 4
		clip: true

		Ripple {
			id: ripple

			width: root.width
		}
	}

	ButtonLabel {
		id: label

		anchors.centerIn: parent
		color: palette.button
	}

	MouseArea {
		id: mouseArea

		anchors.fill: parent
		cursorShape: "PointingHandCursor"

		onPressed: {
			ripple.x = mouse.x - 0.5*ripple.width
			ripple.y = mouse.y - 0.5*ripple.height
			ripple.start()
		}

		onClicked: root.clicked()
	}

	states: [
		State {
			name: "disabled"
			when: !enabled

			PropertyChanges { target: label; color: "#9E9E9E" }
		},
		State {
			name: "focused"
			when: activeFocus

			PropertyChanges { target: base; color: "#F5F5F5" }
		}
	]

	transitions: Transition {
		to: "disabled"
		reversible: true

		ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }

	}
}
