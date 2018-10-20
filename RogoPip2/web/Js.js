var ifOK = true;
var areaRads = [1,2,3,4,5];
const FETCH_TIMEOUT = 3200;
for (k=0; k<5; k++) {
    areaRads[k] = [];
}

var rad = 0;
window.onload = function() {
    var canv = document.getElementById("CheckArea");
    var canvDraw = canv.getContext("2d");
    canv.addEventListener("click",listener,true);
    drawArea();
};

function listener(evt) {
    var didTimeOut = false;
    var canv = document.getElementById("CheckArea");
    var canvDraw = canv.getContext("2d");
    ifOK = true;
    var mousePos = getMousePos(canv, evt);
    var color;
    //var value = [];
    /*  */
    document.getElementById("kXarea").value = (mousePos.x-200)/40;
    document.getElementById("kYarea").value = -(mousePos.y-200)/40;
    document.getElementById("radArea").value = rad;
    evt.preventDefault();
    const formData = new FormData(document.querySelector('#checker2'));
    const params = new URLSearchParams();
    for(const pair of formData.entries()){
        params.append(pair[0], pair[1]);
    }

    //console.log(ifOK);
    //console.log(didTimeOut);

    new Promise(function(resolve, reject) {
        const timeout = setTimeout(function() {
            didTimeOut = true;
            reject(new Error('Request timed out'));
        }, FETCH_TIMEOUT);
        fetch('', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
            },
            body: params.toString()
        }).then(response => response.text())
            .then(htmlTable => document.querySelector('#results').insertAdjacentHTML('beforeend', htmlTable))
            .then(function(response) {
                // Clear the timeout as cleanup
                clearTimeout(timeout);
                if(!didTimeOut) {
                    console.log('fetch good! ', response);
                    ifOK = true;
                    resolve(response);
                }
            })
            .catch(function(err) {
                console.log(err);
                ifOK = false;

                // Rejection already happened with setTimeout
                if(didTimeOut) return;
                // Reject with error
                reject(err);
            });
    })
        .then(function() {
            ifOK = true;
            // Request success and no timeout
            console.log('good promise, no timeout! ');
            canv.addEventListener('click',listener,true);

            if (ifInside(mousePos.x,mousePos.y,rad)) {
                canvDraw.beginPath();
                canvDraw.moveTo(mousePos.x,mousePos.y);
                canvDraw.arc(mousePos.x,mousePos.y,2,0,2*Math.PI,false);
                canvDraw.fillStyle = 'green';
                canvDraw.fill();
                color = 'green';
            } else
            {
                canvDraw.beginPath();
                canvDraw.moveTo(mousePos.x,mousePos.y);
                canvDraw.arc(mousePos.x,mousePos.y,2,0,2*Math.PI,false);
                canvDraw.fillStyle = 'red';
                canvDraw.fill();
                color = 'red';
            }
            var value = [mousePos.x,mousePos.y,2,0,2*Math.PI,false,color];
            areaRads[rad-1].push(value);

        })
        .catch(function(err) {
            // Error: response error, request timeout or runtime error
            ifOK = false;
            alert("Серверные проблемы");
            console.log('promise error! ', err);
            ifOK = true;
        });

    //    canv.removeEventListener('click',listener,true);

}

function drawArea() {
    //  if (chk)
    var canv = document.getElementById("CheckArea");
    var canvDraw = canv.getContext("2d");
    rad = document.getElementById("AreaRad").value;
    canvDraw.clearRect(0,0,canv.width,canv.height);
    var backGround = new Image();
    backGround.src = 'Coordinates.png';
    canvDraw.drawImage(backGround, 0, 0);
    canvDraw.beginPath();
    canvDraw.moveTo(200,200);
    canvDraw.arc(200,200,rad*20,0,0.5*Math.PI,false);
    canvDraw.lineTo(200,200);
    canvDraw.fillStyle = 'LightBlue';
    canvDraw.fill();
    canvDraw.stroke();
    canvDraw.beginPath();
    canvDraw.rect(200-rad*40,200,200-(200-rad*40),200-(200-rad*20));
    canvDraw.fillStyle = 'LightBlue';
    canvDraw.fill();
    canvDraw.stroke();
    canvDraw.beginPath();
    canvDraw.moveTo(200,200);
    canvDraw.lineTo(200,200-rad*40);
    canvDraw.lineTo(200+rad*20,200);
    canvDraw.closePath();
    canvDraw.fillStyle = 'LightBlue';
    canvDraw.fill();
    canvDraw.stroke();
    canv.removeEventListener('click',listener,true);
    if (ifOK) canv.addEventListener('click',listener,true);
    if (areaRads[rad-1].length!==0 && ifOK) {    //-1
        for (l=0; l<areaRads[rad-1].length; l++) { //-1
            canvDraw.beginPath();
            canvDraw.moveTo(areaRads[rad-1][l][0],areaRads[rad-1][l][1]);
            canvDraw.arc(areaRads[rad-1][l][0],areaRads[rad-1][l][1],areaRads[rad-1][l][2],areaRads[rad-1][l][3],areaRads[rad-1][l][4],areaRads[rad-1][l][5]);
            canvDraw.fillStyle = areaRads[rad-1][l][6];
            canvDraw.fill(); }
    }

}
///////////////////////////////////////////////////////////////////////////

function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}


function ifInside(x,y,nesRad) {
    // var rad = document.getElementById("AreaRad").value;
    if ((x>=200) && (y>=200) && ((Math.pow((x-200),2) + Math.pow((y-200),2)) <= Math.pow((nesRad*20),2))) {return true;}
    if ((x>=200) && (y<=200) && ((200-(200+(y-200)))<=((-2)*(x-200)+nesRad*40))) {return true;}
    if ((x<=200) && (y>=200) && (x>=(200-(nesRad*40))) && (y<=(200+(nesRad*20)))) {return true;}
    return false;
}

function checkValid(e) {
    var x, er, text;
    var canv = document.getElementById("CheckArea");
    var canvDraw = canv.getContext("2d");
    er = document.getElementById("errors");
    x = document.getElementById("enter").value;
    x = x.replace(',','.');
    if (isNaN(x) || (x=='')) {
        text = "Ошибка! Координата X - не число";
        er.classList.remove("hidden");
        document.getElementById("errors").innerHTML = text;
        e.preventDefault();
        return false;

    } else {
        if(x < -5 || x > 3) {
            text = " Ошибка! Координата X должна быть от -5 до 3";
            er.classList.remove("hidden");
            document.getElementById("errors").innerHTML = text;
            e.preventDefault();
            return false;
        } else {
            text = "Данные верны";
            er.classList.add("hidden");
            document.getElementById("errors").innerHTML = text;
            e.preventDefault();
            const formData = new FormData(document.querySelector('#checkForm'));
            const params = new URLSearchParams();
            for(const pair of formData.entries()){
                params.append(pair[0], pair[1]);
            }
            fetch('', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                body: params.toString()
            }).then(response => response.text()).then(htmlTable => document.querySelector('#results').insertAdjacentHTML('beforeend', htmlTable));


            var color2;
            var kkx = document.getElementById("enter").value*40+200;
            var kky = document.getElementById("kYY").value*(-40)+200;
            if (ifInside(kkx,kky,rad)) {
                canvDraw.beginPath();
                canvDraw.moveTo(kkx,kky);
                canvDraw.arc(kkx,kky,2,0,2*Math.PI,false);
                canvDraw.fillStyle = 'green';
                canvDraw.fill();
                color2 = 'green';
            } else {
                canvDraw.beginPath();
                canvDraw.moveTo(kkx,kky);
                canvDraw.arc(kkx,kky,2,0,2*Math.PI,false);
                canvDraw.fillStyle = 'red';
                canvDraw.fill();
                color2 = 'red';
            }
            var value2 = [kkx,kky,2,0,2*Math.PI,false,color2];
            areaRads[rad-1].push(value2);
            drawArea();

            return true; }
    }
}
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('check').addEventListener('click', submit);
});
