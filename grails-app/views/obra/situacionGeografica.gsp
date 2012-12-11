<html>
<head>

</head>

<body>

<table class="table table-bordered table-striped table-hover table-condensed" id="tabla">

    <thead>

    <th style="background-color: ${colorProv};">Provincia</th>
    <th style="background-color: ${colorCant};">Cantón</th>
    <th style="background-color: ${colorParr};">Parroquia</th>
    <th style="background-color: ${colorComn};">Comunidad</th>
    <th>Seleccionar</th>
    </thead>

    <tbody>

    <g:each in="${comunidades}" var="comn" status="i">
        <tr>

            <td class="provincia">${comn.parroquia.canton.provincia.nombre}</td>
            <td class="canton">${comn.parroquia.canton.nombre}</td>
            <td class="parroquia">${comn.parroquia.nombre}</td>
            <td class="comunidad">${comn.nombre}</td>
            <td><div style="float: right; margin-right: 5px;" class="ok btnpq ui-state-default ui-corner-all"
                     id="reg_${i}" regId="${comn?.id}" parroquia="${comn?.parroquia?.id}" parroquiaN="${comn?.parroquia?.nombre}"
                     canton="${comn?.parroquia?.canton?.id}"  comN="${comn?.nombre}" txtReg="${comn.toString()}" ${comunidades}>
                <span class="ui-icon ui-icon-circle-check"></span>
            </div></td>

        </tr>

    </g:each>
    </tbody>

</table>

<script type="text/javascript">


    $(".btnpq").click(function () {


        var comunidad = $(this).attr("regId");

        $("#hiddenParroquia").val( $(this).attr("parroquia"));
        $("#parrNombre").val($(this).attr("parroquiaN"));

        $("#hiddenComunidad").val($(this).attr("comunidad"));
        $("#comuNombre").val($(this).attr("comN"));

//        console.log("comunidadId:" + comunidad);

        var parroquia = $(this).attr("parroquia");

//        console.log ("parroquia:" + parroquia);

        var canton = $(this).attr("canton");

//        console.log("canton:" + canton);

        $("#dlgLoad").dialog("open");
        cerrarBusqueda(comunidad,parroquia,canton);

    });

    function cerrarBusqueda(comunidad,parroquia,canton) {


        $("#selParroquia").val(parroquia)
        $("#dlgLoad").dialog("close");
        $("#busqueda").dialog("close");
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'parroquiaComunidad')}",
            data    : {
                comunidad : comunidad,
                parroquia  : parroquia
//                canton   : canton

            },
            success : function (msg) {

//                $("#divTabla").html(msg);
                $("#dlgLoad").dialog("close");
            }
        });

    }


</script>

</body>
</html>