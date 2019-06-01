import QtQuick 2.9


Rectangle {
    color: "transparent"
    anchors.fill: parent

    //get old image in: oldImage	

    Image {
        id: img
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
        smooth: true
        visible: true
        anchors.fill: parent
        source: image
        opacity: 0.0
    }

    PropertyAnimation {id: ani; target: img; property: "opacity"; to: 1.0; duration: 500}

    Component.onCompleted: {
        ani.stop()
        ani.start()
    }
}
