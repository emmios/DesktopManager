import QtQuick 2.9
import QtQuick.Window 2.3
import "./Components"
import "util.js" as Util


App {
    id: main
    visible: true
    //width: 640
    //height: 480
    x: 0
    y: 0
    width: Screen.width
    height: Screen.height
    color: "transparent"
    title: qsTr("Synth-Desktop")
    flags: Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnBottomHint | Qt.WA_X11NetWmWindowTypeDesktop

    property bool mouseDown: true
    property int posx: 0
    property int posy: 0
    property int posxAtual: 0
    property int posyAtual: 0
    property bool fullscreen: true
    property bool btnLeft: true
    property bool mouseHover: true
    property var rect: []
    property var colision_items: []
    property bool colision_selected: false
    property var rected
    property bool selected: false
    property bool mult: false
    property var contextMenu: null


    onActiveChanged: {
        if (!active) {
            if (contextMenu !== null) {
                contextMenu.visible = false
            }
        }
    }

    Rectangle {
        color: "#333"
        anchors.fill: parent
    }

    DropArea {
            id: dropArea;
            anchors.fill: parent;
            onEntered: {
                //console.log("onEntered");
            }
            onDropped: {
                console.log ("onDropped");

                if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
                    console.log("item", drop.urls.toString().split(','))
                    Context.copy(drop.urls.toString().split(',')[0], "/home/shenoisz/Área de Trabalho/")
                    drop.acceptProposedAction()
                }
            }
            onExited: {
                //console.log ("onExited");
            }
    }
/*
    Action {
            shortcut: "Ctrl+A"
            enabled: true
            onTriggered: Util.selectAll()
   }
*/
    Rectangle {
        id: rectangle
        z: 1
        width: 0
        height: 0
        opacity: 0.3
        //color: "#5b83f9"
        color: "#00000000"
        property string detailColor: Context.color()
        Rectangle {
            anchors.fill: parent
            color: rectangle.detailColor//"#5b83f9"
            opacity: 0.8
        }
        Rectangle {
            anchors.fill: parent
            color: "#00000000"
            border {width: 2; color: rectangle.detailColor }
        }
        //border {width: 2; color: Context.color() }//"#3a50e0"}
    }

    Rectangle {
        id: multItems
        z: 99
        width: 15
        height: 15
        color: "#ff0000"
        radius: 15
        visible: false

        Text {
            id: multItemsText
            y: 3
            x: 0
            width: 15
            color: "#fff"
            text: qsTr("1")
            font.pixelSize: 8
            horizontalAlignment: Text.AlignHCenter
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        //drag.target: rected

        onClicked: {

            if (mouse.button & Qt.RightButton) {

                btnLeft = false

                if (contextMenu === null) {
                    var comp = Qt.createComponent("Menu.qml")
                    contextMenu = comp.createObject(main)
                } else {
                    contextMenu.visible = false
                }

                if (mouseX + contextMenu.width > main.width) {
                    contextMenu.x = mouseX - contextMenu.width
                } else {
                    contextMenu.x = mouseX
                }

                if (mouseY + contextMenu.height > main.height) {
                    contextMenu.y = mouseY - contextMenu.height
                } else {
                    contextMenu.y = mouseY
                }

                contextMenu.visible = true
            }

            if (mouse.button & Qt.LeftButton) {
                if (contextMenu !== null) {
                    contextMenu.visible = false
                }

                btnLeft = true
            }
        }

        onPressedChanged: {

            if(btnLeft) {

                if (mouseDown) {

                    if (!mult && !colision_selected) {
                        //select sigle item of desktop
                        Util.selectItem()
                    } else {
                        //select multiples item of desktop
                        Util.colisionSelectItem()
                    }

                    multItems.visible = false
                    rectangle.detailColor = Context.color()
                    rectangle.visible = true
                    rectangle.x = mouseX
                    rectangle.y = mouseY
                    rectangle.width = 0
                    rectangle.height = 0
                    posx = mouseX
                    posy = mouseY
                    mouseDown = false

                } else {

                    //verify if item is hide or part in desktop
                    Util.verifyDesktopPass()

                    multItems.visible = false
                    rectangle.visible = false
                    mouseDown = true
                    selected = false
                    colision_selected = false

                    if (colision_items.length > 0) {
                        mult = true
                    }

                }
            }

        }

        onMouseXChanged: {

            if (btnLeft && selected && !colision_selected) {

                rected.x = mouseArea.mouseX - (rected.width / 2)
                rected.y = mouseArea.mouseY - (rected.height / 2) + 10
            }

            if (btnLeft && colision_selected) {
                var total = 0
                for (var i = 0; i < colision_items.length; i++) {
                    colision_items[i].x = mouseArea.mouseX - colision_items[i].width / 2
                    colision_items[i].y = mouseArea.mouseY - (colision_items[i].height / 2) + 10
                    total++
                }

                multItems.visible = true
                multItems.x = mouseArea.mouseX - multItems.width
                multItems.y = mouseArea.mouseY - multItems.height
                multItemsText.text = total.toString()
            }

            if(btnLeft && !selected && !colision_selected && !mult) {

                var w = mouseArea.mouseX - posx
                var h = mouseArea.mouseY - posy

                if (h > 0 && w > 0) {

                    rectangle.width = w
                    rectangle.height = h

                    Util.conlision(0, posx, posy, mouseX, mouseY)

                } else if (h < 0 && w < 0) {

                    rectangle.x = mouseArea.mouseX
                    rectangle.y = mouseArea.mouseY
                    rectangle.width = w.toString().replace('-', '')
                    rectangle.height = h.toString().replace('-', '')

                    Util.conlision(1, posx, posy, mouseX, mouseY)

                } else if (h < 0 && w > 0) {

                    rectangle.width = w
                    rectangle.height = h.toString().replace('-', '')
                    rectangle.y = posy - rectangle.height

                    Util.conlision(2, posx, posy, mouseX, mouseY)

                } else if (h > 0 && w < 0) {

                    w = w.toString().replace('-', '')
                    rectangle.width = w
                    rectangle.height = h
                    rectangle.x = posx - rectangle.width

                    Util.conlision(3, posx, posy, mouseX, mouseY)
                }

            }
        }
    }

    Item {
        id: content
        anchors.fill: parent
        property alias load: load

        Loader {
            id: load
            anchors.fill: parent
            property string image: Context.getImgBackground()
            property string oldImage: ""
            source: "file:///usr/share/synth/desktop/plugins/start/init.qml"
            onSourceChanged: {
                oldImage = image
            }
        }
    }

    Item {
        id: item2
        anchors.fill: parent
        z: 0
    }

    function wallpaperRefresh(bg) {
        content.load.image = bg
        content.load.setSource("file:///usr/share/synth/desktop/plugins/effect-wallpaper/fade.qml")
    }

    Timer {
        id: time
        running: false
        interval: 6000
        onTriggered: {
//            var comp = Qt.createComponent("Menu.qml")
//            contextMenu = comp.createObject(main)

//            var component = Qt.createComponent("Rectangle1.qml")
//            var h = 0

//            for (var i = 0; i < 3; i++) {
//                var obj = component.createObject(item2, {'x': 10, 'y': 10 + h, 'texto': "arquivos-test " + i})
//                h += 80
//                rect.push(obj)
//            }

            //main.requestActivate()
            flags = Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnBottomHint
            Context.backgroundChange(Context.getImgBackground())
            var comp = Qt.createComponent("Menu.qml")
            contextMenu = comp.createObject(main)
            Context.allDesktop()
        }
    }


    Component.onCompleted: {
        flags = Qt.Tool | Qt.FramelessWindowHint | Qt.WindowStaysOnBottomHint | Qt.WA_X11NetWmWindowTypeDesktop
        //var newObject = Qt.createQmlObject('import QtQuick 2.7; Rectangle {color: "red"; x: 0; y: 0; width: 80; height: 80; z: 9}', item2, "react");
        time.start()

        Context.windowMove(main, 0, 0, Screen.width, Screen.height)
    }
}
