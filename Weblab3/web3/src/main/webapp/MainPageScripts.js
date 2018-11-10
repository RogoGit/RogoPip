var dotArray = []; /// пусть будет пока

var inputRad = document.getElementById("fieldsForm:rad");
var oldRad = 1;

function getMousePos() {

    return {
        x: (event.clientX - 390) / 180,
        y: -(event.clientY - 340) / 180
    };

}

function makeNewDot() {

    var aX = document.getElementById("AreaForm:AreaX");
    var aY = document.getElementById("AreaForm:AreaY");
    var aR = document.getElementById("AreaForm:AreaR");
    aX.value = getMousePos().x;
    aY.value = getMousePos().y;
    aR.value = inputRad.value;
    document.forms["AreaForm"].submit();

}

function resizeArea() {
    var newRad = inputRad.value;

    var dots = document.querySelectorAll("circle[name='dot']");

    for (var i = 0; i < dots.length; i++) {
        var cx = (dots[i].cx.animVal.value - 190) * oldRad / newRad + 190;
        var cy = (dots[i].cy.animVal.value - 210) * oldRad / newRad + 210;

        dots[i].setAttribute("cx", cx);
        dots[i].setAttribute("cy", cy);

        oldRad = inputRad.value;
    }
}

