import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

PanelWindow {
  id: root

  Process {
    id: shellProcess
  }

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
  WlrLayershell.namespace: "leave"

  color: "#40000000"

  anchors.top: true
  anchors.bottom: true
  anchors.left: true
  anchors.right: true

  MouseArea {
    anchors.fill: parent
    onClicked: Qt.quit()
  }

  Rectangle {
    id: logoutBox
    width: 600
    height: 200
    color: "#0c0e16"
    radius: 15
    border.color: "#1d1d2c"
    border.width: 1.2
    anchors.centerIn: parent

    focus: true
    Keys.onEscapePressed: Qt.quit()

    property int currentIndex: 0
    property int count: menuModel.count

    Keys.onLeftPressed: currentIndex = (currentIndex - 1 + count) % count
    Keys.onRightPressed: currentIndex = (currentIndex + 1) % count
    Keys.onReturnPressed: {
      let cmd = menuModel.get(currentIndex).cmd;
      if (cmd) {
        shellProcess.command = ["sh", "-c", cmd];
        shellProcess.startDetached();
      }
      Qt.quit()
    }

    RowLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 15

      Repeater {
        model: ListModel {
          id: menuModel
          ListElement { name: "Shutdown"; icon: "shutdown.svg"; cmd: "hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff' " }
          ListElement { name: "Restart"; icon: "restart.svg"; cmd: "hyprshutdown -t 'Rebooting...' --post-cmd 'systemctl reboot' " }
          ListElement { name: "Logout"; icon: "logout.svg"; cmd: "hyprshutdown -t 'Logging out...'" }
          ListElement { name: "Suspend"; icon: "suspend.svg"; cmd: "systemctl suspend" }
        }

        delegate: Rectangle {
          Layout.fillWidth: true
          Layout.fillHeight: true
          color: (logoutBox.currentIndex === index || mouseArea.containsMouse) ? "#3d3d5c" : "#2a2a3c"
          radius: 10
          Layout.preferredWidth: 100
          border.width: 1.2
          border.color: (logoutBox.currentIndex === index || mouseArea.containsMouse) ? "#2ac3de" : "transparent"

          MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: logoutBox.currentIndex = index
            onClicked: {
              if (model.cmd) {
                shellProcess.command = ["sh", "-c", model.cmd];
                shellProcess.startDetached();
              }
              Qt.quit()
            }
          }

          ColumnLayout {
            anchors.centerIn: parent
            spacing: 10

            Item {
              Layout.preferredWidth: 48
              Layout.preferredHeight: 48
              Layout.alignment: Qt.AlignHCenter
              visible: model.icon !== ""

              Image {
                id: iconImg
                source: model.icon
                anchors.fill: parent
                visible: false
              }

              ColorOverlay {
                anchors.fill: iconImg
                source: iconImg
                color: "#c0caf5"
              }
            }

            Text {
              text: model.name
              color: "#c0caf5"
              font.pixelSize: 14
              font.bold: true
              Layout.alignment: Qt.AlignHCenter
            }
          }
        }
      }
    }
  }
}
