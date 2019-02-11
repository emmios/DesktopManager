/*
* @AUTHOR SHENOISZ
*/


function reset() {

    var rect = main.rect

    // reset objects
    for (var i = 0; i < rect.length; i++) {
        rect[i].z = 0
        rect[i].opacity = 1
        rect[i].color = "transparent"
    }
}


function order() {

    var rect = main.rect
    var order_by = []
    var order_stand = {}


    for (var i = 0; i < rect.length; i++) {
        order_by.push(rect[i].y + i)
        order_stand[rect[i].y + i] = rect[i]
    }

    order_by.sort()
    var ypos = 10

    for (var i = 0; i < order_by.length; i++) {
        order_stand[order_by[i]].x = 10
        order_stand[order_by[i]].y = ypos
        ypos = order_stand[order_by[i]].y + order_stand[order_by[i]].height
    }
}

function selectAll() {

    var rect = main.rect

    for (var i = 0; i < rect.length; i++) {
        rect[i].z = 1
        rect[i].opacity = 0.7
        rect[i].color = "#4a70f5"
        main.colision_items.push(rect[i])
    }
    main.mult = true
}

function colisionReset() {

    var rect = main.colision_items

    // reset objects
    for (var i = 0; i < rect.length; i++) {
        rect[i].z = 0
        rect[i].opacity = 1
        rect[i].color = "transparent"
    }
}

function colisionSelectItem() {

    var rect = main.colision_items
    var mouseX = mouseArea.mouseX
    var mouseY = mouseArea.mouseY
    var clicked = false

    for (var i = 0; i < rect.length; i++) {

        if (rect[i].x < mouseX && rect[i].y < mouseY && (rect[i].x + rect[i].width) > mouseX && (rect[i].y + rect[i].height) > mouseY) {
            clicked = true
            main.colision_selected = true
            break;
        }
    }

    if (!clicked) {
        colisionReset()
        main.colision_selected = false
        main.colision_items = []
        main.mult = false
    }
}

function selectItem() {

    var rect = main.rect
    var mouseX = mouseArea.mouseX
    var mouseY = mouseArea.mouseY

    main.colision_items = []
    reset()

    for (var i = 0; i < rect.length; i++) {

        if (rect[i].x < mouseX && rect[i].y < mouseY && (rect[i].x + rect[i].width) > mouseX && (rect[i].y + rect[i].height) > mouseY) {
            main.rected = rect[i]
            rect[i].z = 1
            rect[i].opacity = 0.7
            rect[i].color = "#4a70f5"
            selected = true
            break;
        }
    }

}

function verifyDesktopPass() {

    var rect = main.rect

    for (var i = 0; i < rect.length; i++) {

        if (rect[i].x <= 10) {
            rect[i].x = 10
        }

        if (rect[i].y <= 10) {
            rect[i].y = 10
        }

        if ((rect[i].x + rect[i].width) >= main.width) {
            rect[i].x = (main.width - rect[i].width) - 10
        }

        if ((rect[i].y + rect[i].height) >= main.height) {
            rect[i].y = (main.height - rect[i].height) - 10
        }
    }
}

function conlision(type, x , y, mouseX, mouseY) {

    var rect = main.rect
    main.colision_items = []

    if (type == 0) {

        for (var i = 0; i < rect.length; i++) {

            if (x < (rect[i].x + rect[i].width) && y < (rect[i].y + rect[i].height) && mouseX > rect[i].x && mouseY > rect[i].y) {
                rect[i].z = 1
                rect[i].opacity = 0.7
                rect[i].color = "#4a70f5"
                main.colision_items.push(rect[i])

            } else {

                rect[i].z = 0
                rect[i].opacity = 1
                rect[i].color = "transparent"
            }
        }
    }

    if (type == 1) {

        for (var i = 0; i < rect.length; i++) {

            if (x > rect[i].x && y > rect[i].y && mouseX < (rect[i].x + rect[i].width) && mouseY < (rect[i].y + rect[i].height)) {
                rect[i].z = 1
                rect[i].opacity = 0.7
                rect[i].color = "#4a70f5"
                main.colision_items.push(rect[i])

            } else {

                rect[i].z = 0
                rect[i].opacity = 1
                rect[i].color = "transparent"

            }
        }
    }

    if (type == 2) {

        for (var i = 0; i < rect.length; i++) {

            if (x < (rect[i].x + rect[i].width)  && y > rect[i].y && mouseX > rect[i].x && mouseY < (rect[i].y + rect[i].height)) {
                rect[i].z = 1
                rect[i].opacity = 0.7
                rect[i].color = "#4a70f5"
                main.colision_items.push(rect[i])

            } else {

                rect[i].z = 0
                rect[i].opacity = 1
                rect[i].color = "transparent"
            }
        }
    }

    if (type == 3) {

        for (var i = 0; i < rect.length; i++) {

            if (x > rect[i].x && y < (rect[i].y + rect[i].height) && mouseX < (rect[i].x + rect[i].width) && mouseY > rect[i].y) {
                rect[i].z = 1
                rect[i].opacity = 0.7
                rect[i].color = "#4a70f5"
                main.colision_items.push(rect[i])

            } else {

                rect[i].z = 0
                rect[i].opacity = 1
                rect[i].color = "transparent"
            }
        }
    }
}
