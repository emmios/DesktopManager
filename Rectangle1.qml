import QtQuick 2.9


Rectangle {

    width: 80
    height: 80
    color: "transparent"

    property string texto: "test"
    property string url: "file:///home/shenoisz/Documents/estudos/QT-creator/DesktopManager/icons/folder.png"

    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: 0
    Drag.hotSpot.y: 0

    Drag.mimeData: { "text/uri-list": "file:///home/shenoisz/Desktop/test.txt" }
    Drag.supportedActions: Qt.CopyAction
    Drag.dragType: Drag.Automatic
    Drag.onDragStarted: { }
    Drag.onDragFinished: {
        console.log("Time to copy")
    }

    Image {
        x: 10
        y: 0
        width: 62
        height: 56
        source: "file:///home/shenoisz/Documents/estudos/QT-creator/DesktopManager/icons/folder.png"
    }

    Text {
        id: item_texto
        x: 5
        y: 62
        text: texto
        font.pixelSize: 12
        color: "#ffffff"
        horizontalAlignment: Text.AlignHCenter
    }
}
