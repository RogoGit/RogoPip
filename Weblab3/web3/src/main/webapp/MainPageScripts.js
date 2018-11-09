var dotArray = []; /// пусть будет пока

var inputRad = document.getElementById("fieldsForm:rad");
var oldRad = 1;

function makeNewDot() {

        if (!(isNaN(inputRad.value) || inputRad.value < 1 || inputRad.value > 4)) {
            var kx = (event.clientX - 390) / 180;
            var ky = -(event.clientY - 340) / 180;
            var radius = inputRad.value;

        } else {

           // document.getElementById("errors").classList.remove("hidden");
            //document.getElementById("errors").innerHTML = "Введите правильный радиус!";
        }
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

