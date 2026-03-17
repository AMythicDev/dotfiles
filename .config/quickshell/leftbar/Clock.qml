import Quickshell
import QtQuick
import Quickshell.Io

Item {
    implicitWidth: clock.width + 40
    implicitHeight: 45

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        
        color: "#0c0e16"
        border.color: "#1d1d2c"
        border.width: 1.2
        radius: 15
    }

    SystemClock {
        id: sysclock
        precision: SystemClock.Minutes
    }

    Text {
        id: clock
        color: "#c0caf5"
        anchors.centerIn: parent
        text: "\udb82\udd54 " + Qt.formatDateTime(sysclock.date, "hh:mm") 
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        font.weight: Font.Medium
    }
}

