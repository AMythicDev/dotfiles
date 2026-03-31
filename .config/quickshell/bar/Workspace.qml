import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Item {
    implicitWidth: workspaceRow.width + 20
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

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 10
        padding: 10

        Repeater {
            model: 10
            delegate: Rectangle {
                id: wsDelegate
                width: 30
                height: 30
                color: "transparent"

                property int wsId: modelData + 1
                property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)
                property bool isFocused: ws ? ws.focused : (Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId)
                
                visible: ws || isFocused

                Rectangle {
                    id: indicator
                    anchors.centerIn: parent
                    
                    width: isFocused ? 25 : 12
                    height: 12
                    radius: 8
                    
                    property bool hasWindows: ws ? ws.toplevels.values.length > 0 : false

                    color: isFocused ? "#ffffff" : (hasWindows ? "#c0caf5" : "#414868")

                    Behavior on width { NumberAnimation { duration: 150 } }
                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (ws) {
                            ws.activate();
                        } else {
                            Hyprland.dispatch("workspace " + wsId);
                        }
                    }
                }
            }
        }
    }
}
