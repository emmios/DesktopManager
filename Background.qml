import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import "./Components"


AppCustom {
    id: bg
    title: "Neon Painel"
    x: (Screen.desktopAvailableWidth / 2) - (920 / 2)
    y: (Screen.desktopAvailableHeight / 2) - (600 / 2)
    width: 920
    height: 600
    flags: Qt.FramelessWindowHint | Qt.Dialog
    color: "#fff"

    MouseArea {
        anchors.fill: parent
        anchors.margins: 2

        onMouseXChanged: {
            if (mouseX > 0) {
                bg.x = Context.mouseX() - (bg.width / 2)
            } else {
                bg.x = Context.mouseX() - 2
            }
        }

        onMouseYChanged: {
            if (mouseY > 0) {
                bg.y = Context.mouseY() - 15
            } else {
                bg.y = Context.mouseY() - 2
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#fff"

    Rectangle {
        x: 10
        y: 35
        width: parent.width - 20
        height: parent.height - 45
        color: "#fff"

        ListModel {
            id: listModel
            function createListElement(arg) {
                return {img: arg}
            }

//            Component.onCompleted: {
//                var imgs = Context.backgrouds(main.path)
//                for (var i = 0; i < imgs.length; i++) {
//                    append(createListElement(imgs[i]))
//                }
//            }

            function reload() {
                clear()
                var imgs = Context.backgrouds(main.path)
                for (var i = 0; i < imgs.length; i++) {
                    append(createListElement(imgs[i]))
                }
            }
        }

        GridView {
            id: gridView1
            anchors.fill: parent
            clip: true

            antialiasing: false

            model: []

            delegate: Item {
                Column {
                    width: gridView1.cellWidth
                    height: gridView1.cellHeight

                    Image {
                        width: parent.width - 10
                        height: parent.height - 10
                        source: "image://pixmap/" + img
                        anchors.horizontalCenter: parent.horizontalCenter
                        antialiasing: false
                        fillMode: Image.PreserveAspectCrop
                        cache: false

                        property string url: img

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                main.imageBg.source = img
                                Context.backgroundChange(img)
                            }
                        }
                    }

                    spacing: 10
                }
            }

            cellWidth: 150
            cellHeight: 100
        }
    }

    }

    Rectangle {
        id: load
        anchors.fill: parent
        color: "#fff"
        AnimatedImage {
            id: loading
            x: (bg.width / 2) - (250 / 2)
            y: (bg.height / 2) - (250 / 2)
            width: 250
            height: 250
            source: "icons/loading.gif"
            asynchronous: true
            cache: false
        }
    }

    Label {
        y: 6
        x: 14
        text: '\uf07c'
        size: 18
        color: "#333"
        font.family: "Font Awesome 5 Free"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileDialog.open()
            }
        }
    }


    Label {
        y: 5
        x: bg.width - 22
        text: '\uf00d'
        size: 18
        color: "#333"
        font.family: "Font Awesome 5 Free"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                bg.close()
            }
        }
    }


    FileDialog {
        id: fileDialog
        title: "Selecione uma pasta"
        folder: shortcuts.home
        selectFolder: true
        onAccepted: {
            main.path = fileDialog.folder.toString().replace('file://', '')
            listModel.reload()
            gridView1.model = listModel
            //console.log("You chose: " + fileDialog.fileUrls, fileDialog.folder)
        }
        onRejected: {
            //console.log("Canceled")
        }
        //Component.onCompleted: visible = true
    }


    Timer {
        id: time
        running: false
        interval: 500
        onTriggered: {
            listModel.reload()
            gridView1.model = listModel
            load.visible = false
            load.destroy()
        }
    }

    Component.onCompleted: {
        time.start()
    }
}
