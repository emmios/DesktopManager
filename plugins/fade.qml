import QtQuick 2.9
import QtGraphicalEffects 1.0

Rectangle {
    color: "#00000000"
    anchors.fill: parent
    //get old image in: oldImage	

    Image {
        id: img
        fillMode: Image.PreserveAspectCrop
        antialiasing: true
        smooth: true
        anchors.fill: parent
        source: image
        visible: false
    }

    HueSaturation {
        id: hue
        anchors.fill: img
        hue: 0.0
        saturation: 0.5
        lightness: 0.0
        source: img
        antialiasing: true
        smooth: true
        opacity: 0.0
    }

    PropertyAnimation {id: ani; target: hue; property: "opacity"; to: 1.0; duration: 500}

    Component.onCompleted: {
        ani.stop()
        ani.start()
    }
}
