<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="Lab1Table.css">
    <link rel="stylesheet" href="Lab1TextField.css">

    <script type="text/javascript">

        var areaRads = [1,2,3,4,5];
        for (k=0; k<5; k++) {
           areaRads[k] = [];
        }

        var rad = 0;
      window.onload = function(e) {
           var canv = document.getElementById("CheckArea");
           var canvDraw = canv.getContext("2d");

          drawArea();
          canv.addEventListener('click', function listener(evt) {
              var mousePos = getMousePos(canv, evt);
              var color;
              //var value = [];
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
              document.getElementById("kXarea").value = (mousePos.x-200)/40;
                 document.getElementById("kYarea").value = -(mousePos.y-200)/40;
                document.getElementById("radArea").value = rad;
              e.preventDefault();
              const formData = new FormData(document.querySelector('#checker2'))
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
              },true);
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
                <br/>Выберите Y: <select name="koordY" id="kYY">
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
                <input type="text" maxlength="30" id="enter" name="koordX" style="width:170px;">
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
            <form action="" method="POST"  id ="checker2">
            <canvas style="background: url(Coordinates.png) no-repeat center center;" id="CheckArea" width="400" height="400"> </canvas>
               <input type = "hidden" name = "koordX" id="kXarea"/>
               <input type = "hidden" name = "koordY" id="kYarea"/>
               <input type = "hidden" name = "radius" id="radArea"/>
           </form>
        </center></td>
    </tr>
</table>
<br/>
<center> <h1> <b> Результаты проверки </b> </h1> </center> <br/>
<center>
<table border="1" id="results" width="80%">
      <tr>
             <th width="20%"> Координата Х  </th>
            <th width="20%"> Координата Y   </th>
             <th width="20%">  Радиус  </th>
                <th width="20%"> Результат </th>
    </tr>
    <%
        ServletContext sct = request.getServletContext();
        ArrayList<String> tabStr = (ArrayList<String>) sct.getAttribute("chTable");
        if (tabStr!=null) {
            for (int i=0; i<tabStr.size();i++) {
                String outS = tabStr.get(i);
                String[] pr = outS.split(" ");%>
                      <%= outS %>
                 <script>
                     var color;
                     var canv = document.getElementById("CheckArea");
                     var canvDraw = canv.getContext("2d");
                     //var value = [];
                     if (ifInside(<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>,<%=pr[5]%>)) {
                         canvDraw.beginPath();
                         canvDraw.moveTo(<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>);
                         canvDraw.arc(<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>,2,0,2*Math.PI,false);
                         canvDraw.fillStyle = 'green';
                         canvDraw.fill();
                         color = 'green';
                     } else
                     {
                         canvDraw.beginPath();
                         canvDraw.moveTo(<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>);
                         canvDraw.arc(<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>,2,0,2*Math.PI,false);
                         canvDraw.fillStyle = 'red';
                         canvDraw.fill();
                         color = 'red';
                     }
                     var value = [<%=Double.parseDouble(pr[1])*40+200%>,<%=Double.parseDouble(pr[3])*(-40)+200%>,2,0,2*Math.PI,false,color];
                     areaRads[<%=pr[5]%>-1].push(value);
                     drawArea();
                 </script>
           <%
            }
        }
    %>
    <script>
        function cl() {
            areaRads[rad-1].length=0; //-1
            drawArea();
            var tbl = document.getElementById("results");
           var rowC = tbl.rows.length;
         /*   for (let i = 0, n = tbl.rows.length; i < n; i++) {
                for (var c = 0, m = tbl.rows[i].cells.length; c < m; c++) { */
            for (let i = rowC - 1; i > 0; i--) {
                if (tbl.rows[i].cells[2].textContent.trim() === rad) {
                    tbl.deleteRow(i);
                }
            }

            fetch(('clearHistory_'+rad), { method: 'POST' });
             //   }
            //}
        }

        function clearAll() {
            for (r=0; r<areaRads.length; r++) {
                areaRads[r].length=0;
            }
            drawArea();
            var tbl = document.getElementById("results");
            var rowCount = tbl.rows.length;
            for (var i = rowCount-1; i > 0; i--) {
                tbl.deleteRow(i);
            }
            fetch('clearHistory', { method: 'POST' });
        }
    </script>
</table>
</center>
</body>
</html>
