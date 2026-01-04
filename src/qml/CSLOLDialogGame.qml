import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

Dialog {
    id: cslolDialogGame
    width: parent.width * 0.9
    height: parent.height * 0.9
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    standardButtons: DialogButtonBox.Ok
    closePolicy: Popup.NoAutoClose
    modal: true
    title: "[必须以管理员身份运行该软件]\r\n选择LOL启动程序 \"League of Legends.exe\"\r\n[国服] WeGameApps/英雄联盟/Game/League of Legends.exe\r\n[外服] Riot Games/League of Legends/Game/League of Legends.exe"
    font.family: "FontAwesome"
    Overlay.modal: Rectangle {
        color: "#aa333333"
    }

    signal selected(string path)

    Item {
        anchors.fill: parent
        Label {
            anchors.centerIn: parent
            font.pointSize: 48
            text: "\uf0ee"
            font.family: "FontAwesome"
        }
        DropArea {
            anchors.fill: parent
            onDropped: function(drop) {
                if (drop.hasUrls) {
                    cslolDialogGame.selected(CSLOLUtils.fromFile(drop.urls[0]))
                }
            }
        }
    }

    footer: RowLayout {
        Layout.fillWidth: true
        Item {
            Layout.fillWidth: true
        }
        DialogButtonBox {
            id: dialogButtonBox
            ToolButton {
                text: qsTr("自动获取")
                onClicked: {
                    let detected = CSLOLUtils.detectGamePath()
                    if (detected === "") {
                        window.showUserError("获取游戏路径失败", "请确保LOL正在运行(在游戏大厅即可,无需进入游戏对局)")
                    } else {
                        cslolDialogGame.selected(detected)
                    }
                }
            }
            ToolButton {
                text: qsTr("选择")
                onClicked: cslolDialogLolPath.open()
            }
            ToolButton {
                text: qsTr("关闭")
                onClicked: cslolDialogGame.close()
                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            }
        }
    }

    CSLOLDialogLoLPath {
        id: cslolDialogLolPath
        folder: CSLOLUtils.toFile(cslolTools.leaguePath)
        onAccepted: {
            cslolDialogGame.selected(CSLOLUtils.fromFile(file))
        }
    }
}

