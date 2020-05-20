import QtQuick 2.9
import QtQuick.Window 2.3
import QtGraphicalEffects 1.0

Rectangle {
    color: "#00000000"
	anchors.fill: parent

	Image {
        id: img
	    fillMode: Image.PreserveAspectCrop
	    antialiasing: true
            smooth: true
	    visible: false
	    anchors.fill: parent
            source: image
	}

    HueSaturation {
        id: hue
	x: Screen.width / 2
	y: Screen.height / 2
	width: 0
	height: 0
        //anchors.fill: img
        hue: 0.0
        saturation: 0.5
        lightness: 0.0
        source: img
        antialiasing: true
        smooth: true
    }

    /*
	FastBlur {
	    id: fastBlur
	    x: Screen.width / 2
	    y: Screen.height / 2
	    width: 0
	    height: 0
	    antialiasing: true
	    smooth: true
	    //anchors.fill: parent
	    source: img
	    radius: 0
    }*/

    PropertyAnimation {id: animation; target: hue; property: "width"; to: Screen.width; duration: 300}
        PropertyAnimation {id: animation2; target: hue; property: "x"; to: 0; duration: 300}
        PropertyAnimation {id: animation3; target: hue; property: "height"; to: Screen.height; duration: 300}
        PropertyAnimation {id: animation4; target: hue; property: "y"; to: 0; duration: 300}

	Timer {
            id: wallpaperShow
            running: false
            interval: 2000
            onTriggered: {
		    animation.stop()
		    animation.start()
		    animation2.stop()
		    animation2.start()
		    animation3.stop()
		    animation3.start()
		    animation4.stop()
		    animation4.start()
        }
    }

    Component.onCompleted: {
        wallpaperShow.start()
    }	
}
