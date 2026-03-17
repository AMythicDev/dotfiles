import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    WlrLayershell.namespace: "launcher"

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    // color: "#40000000"
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }

    Rectangle {
        id: launcherBox
        width: 600
        height: 450
        color: "#0c0e16"
        radius: 15
        border.color: "#1d1d2c"
        border.width: 1.2
        anchors.centerIn: parent
        clip: true

        MouseArea { anchors.fill: parent }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            RowLayout {
                Layout.fillWidth: true
                spacing: 15

                Text {
                    text: "󰀻"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 24
                    color: "#4aa6d3"
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    color: "#161925"
                    radius: 10
                    border.color: searchInput.activeFocus ? "#4aa6d3" : "#1d1d2c"
                    border.width: 1.2

                    TextInput {
                        id: searchInput
                        anchors.fill: parent
                        anchors.leftMargin: 15
                        anchors.rightMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        color: "#c0caf5"
                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                        focus: true
                        
                        Text {
                            text: "Search apps..."
                            color: "#414868"
                            font: parent.font
                            visible: parent.text === "" && !parent.activeFocus
                            anchors.fill: parent
                            verticalAlignment: Text.AlignVCenter
                        }

                        onTextChanged: appModel.update()

                        Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_Escape) {
                                Qt.quit();
                                event.accepted = true;
                            } else if (event.key === Qt.Key_Down) {
                                if (appListView.count > 0) {
                                    var nextIndex = (appListView.currentIndex + 1) % appListView.count;
                                    appListView.currentIndex = nextIndex;
                                    if (nextIndex === 0) {
                                        appListView.positionViewAtBeginning();
                                    } else {
                                        appListView.positionViewAtIndex(nextIndex, ListView.Contain);
                                    }
                                }
                                event.accepted = true;
                            } else if (event.key === Qt.Key_Up) {
                                if (appListView.count > 0) {
                                    var prevIndex = (appListView.currentIndex - 1 + appListView.count) % appListView.count;
                                    appListView.currentIndex = prevIndex;
                                    if (prevIndex === appListView.count - 1) {
                                        appListView.positionViewAtEnd();
                                    } else {
                                        appListView.positionViewAtIndex(prevIndex, ListView.Contain);
                                    }
                                }
                                event.accepted = true;
                            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                if (appListView.count > 0) {
                                    launchApp(appModel.filteredApps[appListView.currentIndex]);
                                }
                                event.accepted = true;
                            }
                        }
                    }
                }
            }

            ListView {
                id: appListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 4
                model: appModel.filteredApps
                currentIndex: 0
                highlightFollowsCurrentItem: true

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 56
                    radius: 8
                    color: ListView.isCurrentItem ? "#1d1d2c" : "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 15

                        Image {
                            source: modelData.icon ? "image://icon/" + modelData.icon : "image://icon/application-x-executable"
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 32
                            fillMode: Image.PreserveAspectFit
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2
                            Text {
                                text: modelData.name
                                color: ListView.isCurrentItem ? "#ffffff" : "#c0caf5"
                                font.pixelSize: 15
                                font.bold: true
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            Text {
                                text: modelData.comment || ""
                                color: "#565f89"
                                font.pixelSize: 12
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                                visible: text !== ""
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: appListView.currentIndex = index
                        onClicked: launchApp(modelData)
                    }
                }
            }
        }
    }

    Connections {
        target: DesktopEntries.applications
        function onValuesChanged() { appModel.update(); }
    }

    QtObject {
        id: appModel
        property var filteredApps: []

        function update() {
            var all = DesktopEntries.applications.values;
            if (!all) return;
            var f = searchInput.text.toLowerCase();
            var res = [];
            for (var i = 0; i < all.length; i++) {
                var app = all[i];
                if (app.noDisplay) continue;
                
                var name = (app.name || "").toLowerCase();
                var comment = (app.comment || "").toLowerCase();
                
                if (f === "" || name.includes(f) || comment.includes(f)) {
                    res.push(app);
                }
            }
            res.sort(function(a, b) {
                return a.name.localeCompare(b.name);
            });
            filteredApps = res;
            appListView.currentIndex = 0;
            appListView.positionViewAtBeginning();
        }

        Component.onCompleted: update()
    }

    function launchApp(app) {
        if (app) {
            app.execute();
            Qt.quit();
        }
    }
}
