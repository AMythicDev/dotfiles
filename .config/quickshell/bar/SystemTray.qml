import Quickshell
import QtQuick
import Quickshell.Services.SystemTray

Item {
    id: tray
    implicitWidth: trayRow.implicitWidth + 30
    implicitHeight: 45
    visible: trayRow.implicitWidth > 0

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: trayRow.implicitWidth + 30
        height: 30
        
        color: "#0c0e16"
        border.color: "#1d1d2c"
        border.width: 1.2
        radius: 15

        Row {
            id: trayRow
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: SystemTray.items
                delegate: Item {
                    id: trayItemDelegate
                    width: 24
                    height: 24
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        source: modelData.icon
                        fillMode: Image.PreserveAspectFit
                    }
                    
                    QsMenuAnchor {
                        id: menuAnchor
                        menu: modelData.menu
                        anchor.item: trayMouseArea
                    }

                    MouseArea {
                        id: trayMouseArea
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        
                        onPressed: (mouse) => {
                            mouse.accepted = true;
                        }
                        
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.RightButton && modelData.menu) {
                                menuAnchor.open();
                            } else if (mouse.button === Qt.LeftButton) {
                                modelData.activate();
                                // Some items don't have activate but use the menu for everything.
                                if (modelData.menu && !modelData.isStatus) {
                                    menuAnchor.open();
                                }
                            } else if (mouse.button === Qt.MiddleButton) {
                                modelData.secondaryActivate();
                            }
                        }
                    }
                }
            }
        }
    }
}
