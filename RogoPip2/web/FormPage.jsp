<%@ page import="java.util.ArrayList" %>
<%@ page import="com.rogo.Store" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="Lab1Table.css">
    <link rel="stylesheet" href="Lab1TextField.css">
    <script type="text/javascript" src="Js.js"> </script>

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
                <input type = "hidden" name = "name" value="TextForm"/>
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
                <input type = "hidden" name = "name" id="fname" value="AreaForm"/>
               <input type = "hidden" name = "koordX" id="kXarea"/>
               <input type = "hidden" name = "koordY" id="kYarea"/>
               <input type = "hidden" name = "radius" id="radArea"/>
             <!--   <input type = "hidden" name = "ch" id="ch"/> -->
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
        ArrayList<com.rogo.Store> tabStr = (ArrayList<com.rogo.Store>) sct.getAttribute("chTable");
        if (tabStr!=null) {
            for (int i=0; i<tabStr.size();i++) {
                com.rogo.Store outS = tabStr.get(i); %>
                  <tr>
                      <td> <%= outS.x %></td>
                      <td> <%= outS.y %></td>
                      <td> <%= outS.rad %></td>
                      <td> <%= outS.res %></td>
                  </tr>
    <%
             //   String[] pr = outS.split(" "); %>
                 <script>
                     var color;
                     var canv = document.getElementById("CheckArea");
                     var canvDraw = canv.getContext("2d");
                     //var value = [];
                     if (ifInside(<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>,<%=outS.rad%>)) {
                         canvDraw.beginPath();
                         canvDraw.moveTo(<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>);
                         canvDraw.arc(<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>,2,0,2*Math.PI,false);
                         canvDraw.fillStyle = 'green';
                         canvDraw.fill();
                         color = 'green';
                     } else
                     {
                         canvDraw.beginPath();
                         canvDraw.moveTo(<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>);
                         canvDraw.arc(<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>,2,0,2*Math.PI,false);
                         canvDraw.fillStyle = 'red';
                         canvDraw.fill();
                         color = 'red';
                     }
                     var value = [<%=Double.parseDouble(outS.x)*40+200%>,<%=Double.parseDouble(outS.y)*(-40)+200%>,2,0,2*Math.PI,false,color];
                     areaRads[<%=outS.rad%>-1].push(value);
                     drawArea(evt);
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

            fetch('clearHistory', { method: 'POST', body: 'rad='+rad, headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',} });
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
