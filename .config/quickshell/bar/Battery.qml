import Quickshell
import QtQuick
import Quickshell.Services.UPower

Item {
    implicitWidth: batteryText.width + 30
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
        id: batteryText
        anchors.centerIn: parent
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        font.weight: Font.Medium
        
        property int percentage: UPower.displayDevice ? Math.round(UPower.displayDevice.percentage * 100) : 0
        property int state: UPower.displayDevice ? UPower.displayDevice.state : 0
        property bool isCharging: state === 1 || state === 4 || state === 5

        color: {
            if (isCharging) return "#9ece6a";
            if (percentage > 20) return "#7dcfff";
            return "#f5c2e7";
        }
        
        text: {
            if (!UPower.displayDevice) return "󰂎 --%";
            
            let icon = "󰂎";
            if (isCharging) {
                if (percentage >= 95) icon = "󰂅";
                else if (percentage >= 90) icon = "󰂋";
                else if (percentage >= 80) icon = "󰂊";
                else if (percentage >= 70) icon = "󰢞";
                else if (percentage >= 60) icon = "󰂉";
                else if (percentage >= 50) icon = "󰢝";
                else if (percentage >= 40) icon = "󰂈";
                else if (percentage >= 30) icon = "󰂇";
                else if (percentage >= 20) icon = "󰂆";
                else if (percentage >= 10) icon = "󰢜";
                else icon = "󰢟";
            } else {
                if (percentage >= 95) icon = "󰁹";
                else if (percentage >= 90) icon = "󰂂";
                else if (percentage >= 80) icon = "󰂁";
                else if (percentage >= 70) icon = "󰂀";
                else if (percentage >= 60) icon = "󰁿";
                else if (percentage >= 50) icon = "󰁾";
                else if (percentage >= 40) icon = "󰁽";
                else if (percentage >= 30) icon = "󰁼";
                else if (percentage >= 20) icon = "󰁻";
                else if (percentage >= 10) icon = "󰁺";
                else icon = "󰂎";
            }
            return icon + " " + percentage + "%";
        }
    }
}
