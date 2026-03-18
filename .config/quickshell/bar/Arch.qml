import Quickshell
import QtQuick
import Quickshell.Io

Item {
    implicitWidth: archItemText.width + 30
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

    Text {
        id: archItemText
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -1
        color: "#4aa6d3"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 18
        font.bold: true
        text: "󰣇"
    } 
}
