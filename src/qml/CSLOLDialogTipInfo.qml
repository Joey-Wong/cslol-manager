import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.15

Dialog {
    id: cslolDialogTipInfo
    width: parent.width * 0.9
    height: parent.height * 0.9
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    standardButtons: DialogButtonBox.Ok
    closePolicy: Popup.NoAutoClose
    modal: true
    title: "开源免费软件,禁止倒卖"
    font.family: "FontAwesome"
    Overlay.modal: Rectangle {
        color: "#aa333333"
    }

    signal closed()  // 添加关闭信号

    Item {
        anchors.fill: parent
        Label {
            anchors.centerIn: parent
            font.pointSize: 16
            text: "该软件是开源免费软件,如果你是买的,请退款!"
            font.family: "FontAwesome"
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
                text: qsTr("我知道了")
                onClicked: {
                    cslolDialogTipInfo.close()
                    cslolDialogTipInfo.closed()  // 触发关闭信号
                }
                DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            }
        }
    }
}

