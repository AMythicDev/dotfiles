import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Item {
    id: win_panel
    implicitWidth: titleText.implicitWidth + 30
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

        Text {
            id: titleText
            anchors.centerIn: parent
            
            // Checks if the globally active toplevel is on the currently focused workspace.
            // This prevents showing titles of windows that are on other workspaces.
            text: {
                if (!Hyprland.activeToplevel) return "Desktop";
                var ws = Hyprland.activeToplevel.workspace;
                if (!ws) return "Desktop";
                return ws.focused ? Hyprland.activeToplevel.title : "Desktop";
            }
            
            color: "#c0caf5"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            font.weight: Font.Medium
            
            elide: Text.ElideRight
            maximumLineCount: 1
            width: Math.min(implicitWidth, parent.width - 20) 
        }
    }
}
