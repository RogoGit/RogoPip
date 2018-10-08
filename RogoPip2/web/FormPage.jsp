<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="Lab1Table.css">
    <link rel="stylesheet" href="Lab1TextField.css">

    <script type="text/javascript">

        //var areaRads = [];
        //areaRads[0] = [1,2,3,4,5];
        var areaRads = [1,2,3,4,5];
        for (k=0; k<5; k++) {
           areaRads[k] = [];
        }
        //var canv = document.getElementById("CheckArea");
       // var canvDraw = canv.getContext("2d");
        var rad = 0;
      window.onload = function() {
           var canv = document.getElementById("CheckArea");
           var canvDraw = canv.getContext("2d");
         // var can2 = document.getElementById("can2");
         // var ctx = can2.getContext("2d");
          // var backGround = new Image();
                         //  backGround.src = 'Coordinates.png';
           //    canvDraw.drawImage(backGround, 0, 0);
           /*ctx.drawImage(canv,0,0);
           canvDraw.clearRect(0,0,canv.width,canv.height);
           canvDraw.drawImage(backGround,0,0);
           canvDraw.drawImage(can2,0,0); */
          drawArea();
          canv.addEventListener('click', function listener(evt) {
              var mousePos = getMousePos(canv, evt);
              var color;
              //var value = [];
              if (ifInside(mousePos.x,mousePos.y)) {
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
              areaRads[rad-1].push(value);},true);
       };


       function drawArea() {
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
            if (areaRads[rad-1].length!==0) {    //-1
                 for (l=0; l<areaRads[rad-1].length; l++) { //-1
                canvDraw.beginPath();
                canvDraw.moveTo(areaRads[rad-1][l][0],areaRads[rad-1][l][1]);
                canvDraw.arc(areaRads[rad-1][l][0],areaRads[rad-1][l][1],areaRads[rad-1][l][2],areaRads[rad-1][l][3],areaRads[rad-1][l][4],areaRads[rad-1][l][5]);
                canvDraw.fillStyle = areaRads[rad-1][l][6];
                canvDraw.fill(); }
            }



       }

       function cl() {
           var rad = document.getElementById("AreaRad").value;
           areaRads[rad-1].length=0; //-1
          // areaRads[0][rad].slice(0);
           drawArea();
          // for (i=0; i<areaRads[rad].length; i++) {
            //   areaRads[rad][i] = (0,0,0,0,0,false);
          // }
       }

     function clearAll() {
          //for (j=0; j<4; j++) {
             // for (i = 0; i < areaRads[rad].length; i++) {
               //   areaRads[j][i] = (0, 0, 0, 0, 0, false);
              //}
          //}
        for (r=0; r<areaRads.length; r++) {
             areaRads[r].length=0;
         }
         drawArea();
     }

        function getMousePos(canvas, evt) {
            var rect = canvas.getBoundingClientRect();
            return {
                x: evt.clientX - rect.left,
                y: evt.clientY - rect.top
            };
        }


       function ifInside(x,y) {
           var rad = document.getElementById("AreaRad").value;
           if ((x>=200) && (y>=200) && ((Math.pow((x-200),2) + Math.pow((y-200),2)) <= Math.pow((rad*20),2))) {return true;}
           if ((x>=200) && (y<=200) && ((200-(200+(y-200)))<=((-2)*(x-200)+rad*40))) {return true;}
           if ((x<=200) && (y>=200) && (x>=(200-(rad*40))) && (y<=(200+(rad*20)))) {return true;}
           return false;
       }

        /*canv.addEventListener('click', function(evt) {
            var mousePos = getMousePos(canv, evt);
            if (ifInside(mousePos.x,mousePos.y)) {
              canvDraw.beginPath();
              canvDraw.moveTo(mousePos.x,mousePos.y);
              canvDraw.arc(mousePos.x,mousePos.y,1,0,2*Math.PI,false);
              canvDraw.fillStyle = 'green';
              canvDraw.fill();
            } else
            {
                canvDraw.beginPath();
                canvDraw.moveTo(mousePos.x,mousePos.y);
                canvDraw.arc(mousePos.x,mousePos.y,1,0,2*Math.PI,false);
                canvDraw.fillStyle = 'red';
                canvDraw.fill();
            }
        },false); */
      //window.onload = drawArea();
        //window.onload = drawCoordSyst();


        function checkValid(e) {
            var x, er, text;

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
                    const formData = new FormData(document.querySelector('#checkForm'))
                    const params = new URLSearchParams();
                    for(const pair of formData.entries()){
                        params.append(pair[0], pair[1]);
                    }
                   // return params.toString();
                    fetch('', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                        },
                        body: params.toString()
                    }).then(response => response.text()).then(htmlTable => document.querySelector('#results').insertAdjacentHTML('beforeend', htmlTable));
                    //   return true;

                    //         /er.classList.add("hidden");
                    //          / document.getElementById("errors").innerHTML = text;
                    //  e.preventDefault();
                    return true; }
            }
        }

       // function drawCoordSyst() {

           /* canvDraw.beginPath();
            canvDraw.rect(0,0,400,400);
            canvDraw.fillStyle = "Coordinates.png";
            canvDraw.fill();*/
     //   }
//document.getElementById('AreaRad').setAttribute('onchange','drawArea()');


        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('check').addEventListener('click', submit);
        });



    </script>

</head>
<body>
<table>
    <tr>
        <th colspan=2 class="hat">Лабораторная №2, Рогаленко Н.А, Р3202, вар 20201</th>
    </tr>
    <tr>
        <th width="45%" class="subHat">Выбор параметров</th>
        <th width="55%" class="subHat">Область координат</th>
    </tr>
    <tr>
        <td width="45%">
            <form action="" method="POST"  name ="checker" id="checkForm">
                Выберите R: <select name="radius" id = "AreaRad" onchange="drawArea()">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select> <br/>
                <br/>Выберите Y: <select name="koordY">
                <option value="-4">-4</option>
                <option value="-3">-3</option>
                <option value="-2">-2</option>
                <option value="-1">-1</option>
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
                <br/>
                <br/> Введите X: <div class="tooltip">
                <input type="text" id="enter" name="koordX" style="width:170px;">
                <span class="tooltiptext">Введите число от -5 до 3</span>
            </div>
                <br/><br/>
                <!-- onclick="validate()"-->
                <br/> <center> <input type="submit" id = "check" value="Проверить попадание" style = "width:80%; height:25px;" onClick= "checkValid(event)"> </center>
                <br/>
                <br/> <center> <input type="button" id = "cle" value="Убрать точки текущего R" style = "width:80%; height:25px;" onClick= "cl()"> </center>
                <br/>
                <br/> <center> <input type="button" id = "clAll" value="Убрать точки для всех R" style = "width:80%; height:25px;" onClick= "clearAll()"> </center>
                <br/>
                <br/> <div id="errors" class="hidden" style="width:90%;"></div>

            </form>

        </td>
        <td width="55%" class = "area"> <center>
          <!--  <canvas id="can2" width="400" height="400"> </canvas> -->
            <canvas style="background: url(Coordinates.png) no-repeat center center;" id="CheckArea" width="400" height="400"> </canvas>
        </center></td>
    </tr>
</table>
<br/>
<center> <h1> <b> Результаты проверки </b> </h1> </center> <br/>
<center>
<table border="1" id="results" width="80%">
      <tr>
                <th colspan="3" width="40%"> Полученные данные </th>
                <th rowspan="2" width="20%"> Результат </th>
    </tr>
    <tr>
        <th> Координата Х  </th>
        <th> Координата Y   </th>
        <th>  Радиус  </th>
    </tr>
</table>
</center>
</body>
</html>
