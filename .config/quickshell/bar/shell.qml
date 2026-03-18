//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 45
    color: "transparent"
    
    // Explicitly set layer and exclusivity
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.exclusiveZone: 45

    Item {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        // Left section
        Row {
            id: leftRow
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            z: 10

            Arch { }
            Battery { }
            Clock { }
        }

        // Center section
        Workspace { 
            id: centerWorkspace
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            z: 10
        }

        // Right section
        Row {
            id: rightRow
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            z: 100

            SystemTray { 
                z: 110
            }

            ActiveWindow { 
                width: Math.min(implicitWidth, 300)
                z: 100
            }
        }
    }
}
