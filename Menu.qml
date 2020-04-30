import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import "util.js" as Util

Window {
    id: menu
    title: "Neon Painel"
    width: 134
    height: 40 * 6
    color: "transparent"
    visible: false
    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Popup

    property string detailColor: Context.color()

    onActiveChanged: {
        if (!active) {
            menu.visible = false
        } else {
            detailColor = Context.color()
            blur.source = Context.blurEffect(menu, 0)
        }
    }

    onVisibleChanged: {
        if (visible) {
            detailColor = Context.color()
            blur.source = Context.blurEffect(menu, 0)
        }
    }

    /*
    Rectangle {
        id: bgColor
        color: "#fff"
        opacity: 0.92
        radius: 0
        anchors.fill: parent
    }

    Image {
        id: bgImage
        anchors.fill: parent
        source: "qrc:/Resources/noise.png"
        opacity: 0.08
    }*/

    BlurEffect {
        id: blur
    }

    Rectangle {
        anchors.fill: parent
        color: "#333"
        opacity: 0.5
    }

    Image {
        anchors.fill: parent
        source: "/Resources/noise.png"
        opacity: 0.1
    }

    Item {
        id: item1
        anchors.fill: parent

        Rectangle {
            id: rectangle1
            color: "transparent"
            visible: true
            anchors.fill: parent
            z: 1

            ListView {
                id: listView
                interactive: false
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 5
                anchors.fill: parent
                model: ListModel {
                    ListElement {
                        name: "Criar Pasta"
                        itemName: "Create Folder"
                    }

                    ListElement {
                        name: "Criar Arquivo"
                        itemName: "Create File"
                    }

                    ListElement {
                        name: "Colar"
                        itemName: "Paste"
                    }

                    ListElement {
                        name: "Abrir Terminal"
                        itemName: "Open Terminal"
                    }

                    ListElement {
                        name: "Wallpapers"
                        itemName: "Background"
                    }

                    ListElement {
                        name: "Organizar"
                        itemName: "Organization"
                    }
                }
                delegate: Item {
                    x: 5
                    width: 80
                    height: 40
                    Row {
                        id: row1
                        spacing: 10
                        property string name: itemName

                        Rectangle {
                            x: 0
                            width: 120
                            height: 25
                            color: "transparent"
                            smooth: mouseArea.containsMouse

                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                hoverEnabled: true

                                onHoveredChanged: {
                                     item_select.color = detailColor
                                     //text_select.color = "#ffffff"
                                }

                                onExited: {
                                    item_select.color = "transparent"
                                    //text_select.color = "#111111"
                                }

                                onPressed: {

                                    if(mouse.button & Qt.LeftButton) {

                                        if (name == "Abrir Terminal") {
                                            Context.terminal()
                                        }

                                        if (name == "Organizar") {
                                            Util.order()
                                        }

                                        if (name == "Wallpapers") {
                                            Context.wallpapers()
                                        }

                                        item_select.color = "transparent"
                                        //text_select.color = "#111111"
                                        menu.visible = false
                                    }
                                }
                            }

                            Rectangle {
                                id: item_select
                                x: -5
                                width: 134
                                height: 25
                                color: "transparent"
                                //opacity: 0.5
                            }

                            Text {
                                id: text_select
                                x: 10
                                text: name
                                width: 100
                                color: "#fff"//"#161616"
                                font.pixelSize: 12
                                font.family: "roboto light"
                                font.bold: true
                                antialiasing: true
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#00000000"
        border { width: 1; color: "#fff" }
        opacity: 0.2
    }
}
