<div class="row-fluid" style="margin-left: 0px">
    <div class="span5" style="margin-bottom: 5px">
        <b>Subpresupuesto:</b>
        <g:select name="subpresupuesto" from="${subPres}" optionKey="id" optionValue="descripcion" style="width: 300px;font-size: 10px" id="subPres_desc" value="${subPre}"></g:select>

        %{--todo descomentar esto--}%
        %{--<g:select name="subpresupuesto" from="${subPresupuesto1}" optionKey="id" optionValue="descripcion" style="width: 300px;font-size: 10px" id="subPres_desc" value="${subPre}"></g:select>--}%


        <a href="#" class="btn btn-ajax btn-new" id="ordenarAsc" title="Ordenar Ascendentemente">
            <i class="icon-arrow-up"></i>
            Ascendentemente
        </a>
        <a href="#" class="btn btn-ajax btn-new" id="ordenarDesc" title="Ordenar Descendentemente">
            <i class="icon-arrow-down"></i>
            Descendentemente
        </a>




    </div>

    %{--<div class="span2">--}%

    %{--</div>--}%

    <div class="span1">
        <div class="btn-group" data-toggle="buttons-checkbox">
            <button type="button" id="ver_todos" class="btn btn-info ${(!subPre)?'active':''} " style="font-size: 10px">Ver todos</button>

        </div>

    </div>


    <div class="span4" style="width: 500px">



        <a href="#" class="btn  " id="copiar_rubros">
            <i class="icon-copy"></i>
            Copiar Rubros
        </a>
        <a href="#" class="btn  " id="imprimir_sub">
            <i class="icon-file"></i>
            Imprimir Subpresupuesto
        </a>

        <a href="#" class="btn  " id="imprimir_excel" style="margin-left:-5px">
            <i class="icon-table"></i>
            Excel
        </a>

    </div>



</div>
<table class="table table-bordered table-striped table-condensed table-hover">
    <thead>
    <tr>
        <th style="width: 20px;">
            #
        </th>
        <th style="width: 200px;">
            Subpresupuesto
        </th>
        <th style="width: 80px;">
            Código
        </th>
        <th style="width: 400px;">
            Rubro
        </th>
        <th style="width: 60px" class="col_unidad">
            Unidad
        </th>
        <th style="width: 80px">
            Cantidad
        </th>
        <th class="col_precio" style="display: none;">Unitario</th>
        <th class="col_total" style="display: none;">C.Total</th>
        <th style="width: 40px" class="col_delete"></th>
    </tr>
    </thead>
    <tbody id="tabla_material">

    <g:each in="${valores}" var="val" status="j">
        <tr class="item_row" id="${val.item__id}" item="${val}" sub="${val.sbpr__id}">

            <td style="width: 20px" class="orden">${val.vlobordn}</td>
            <td style="width: 200px" class="sub">${val.sbprdscr.trim()}</td>
            <td class="cdgo">${val.rbrocdgo.trim()}</td>
            <td class="nombre">${val.rbronmbr.trim()}</td>
            <td style="width: 60px !important;text-align: center" class="col_unidad">${val.unddcdgo.trim()}</td>
            <td style="text-align: right" class="cant">
                <g:formatNumber number="${val.vlobcntd}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/>
            </td>
             <td class="col_precio" style="display: none;text-align: right" id="i_${val.item__id}"><g:formatNumber number="${val.pcun}" format="##,##0" minFractionDigits="2" maxFractionDigits="2" locale="ec"/></td>
            <td class="col_total total" style="display: none;text-align: right"><g:formatNumber number="${val.totl}" format="##,##0"  minFractionDigits="2" maxFractionDigits="2" locale="ec"/></td>
            <td style="width: 40px;text-align: center" class="col_delete">
                <a class="btn btn-small btn-danger borrarItem" href="#" rel="tooltip" title="Eliminar" iden="${val.vlob__id}">
                    <i class="icon-trash"></i></a>
            </td>

        </tr>
    </g:each>

    </tbody>
</table>



<div id="desgloseDialog">

    <fieldset>
        <div class="span3">

            Imprimir el rubro con desglose de transporte?

        </div>
    </fieldset>
</div>


<script type="text/javascript">

    $.contextMenu({
        selector: '.item_row',
        callback: function(key, options) {
            if(key=="edit"){
                $(this).dblclick()
            }
            if(key=="print"){
                %{--var dsps=${obra.distanciaPeso}--}%
                %{--var dsvs=${obra.distanciaVolumen}--}%
                %{--var volqueta=${precioVol}--}%
                %{--var chofer=${precioChof}--}%
                %{--var datos = "?dsps="+dsps+"&dsvs="+dsvs+"&prvl="+volqueta+"&prch="+chofer+"&fecha="+$("#fecha_precios").val()+"&id=${rubro?.id}&lugar="+$("#ciudad").val()--}%
                %{--location.href="${g.createLink(controller: 'reportes3',action: 'imprimirRubro')}"+datos--}%
                %{--var datos = "?fecha=${obra.fechaPreciosRubros?.format('dd-MM-yyyy')}Wid="+$(this).attr("item")+"Wobra=${obra.id}"--}%
                %{--var datos = "?fecha=${obra.fechaPreciosRubros?.format('dd-MM-yyyy')}Wid="+$(this).attr("id") +"Wobra=${obra.id}"--}%

                %{--var url = "${g.createLink(controller: 'reportes3',action: 'imprimirRubroVolObra')}"+datos--}%
                %{--location.href="${g.createLink(controller: 'pdf',action: 'pdfLink')}?url="+url--}%

                $("#desgloseDialog").dialog("open");



            }


            if(key=="foto"){
                %{--var child = window.open('${createLink(controller:"rubro",action:"showFoto")}/'+$(this).attr("item"), 'Mies', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');--}%
                var child = window.open('${createLink(controller:"rubro",action:"showFoto")}/'+$(this).attr("id"), 'Mies', 'width=850,height=800,toolbar=0,resizable=0,menubar=0,scrollbars=1,status=0');
                if (child.opener == null)
                    child.opener = self;
                window.toolbar.visible = false;
                window.menubar.visible = false;
            }
        },
        <g:if test="${obra?.estado!='R'}">
        items: {
            "edit": {name: "Editar", icon: "edit"},
            "print": {name: "Imprimir", icon: "print"},
            "foto":{name:"Ilustración",icon:"doc"}
        }
        </g:if>
        <g:else>
        items: {
            "print": {name: "Imprimir", icon: "print"},
            "foto":{name:"Foto",icon:"doc"}
        }
        </g:else>
    });

    $("#imprimir_sub").click(function(){

        var dsps=${obra.distanciaPeso}
        var dsvs=${obra.distanciaVolumen}
        var volqueta=${precioVol}
        var chofer=${precioChof}
        %{--var datos = "?dsps="+dsps+"&dsvs="+dsvs+"&prvl="+volqueta+"&prch="+chofer+"&fecha="+$("#fecha_precios").val()+"&id=${rubro?.id}&lugar="+$("#ciudad").val()--}%
        %{--location.href="${g.createLink(controller: 'reportes3',action: 'imprimirRubro')}"+datos--}%
        var datos = "?obra=${obra.id}Wsub="+$("#subPres_desc").val()
        var url = "${g.createLink(controller: 'reportes3',action: 'imprimirTablaSub')}"+datos
        location.href="${g.createLink(controller: 'pdf',action: 'pdfLink')}?url="+url

    });

    $("#imprimir_excel").click(function () {
//        var $boton = $(this).clone(true)
//        $(this).replaceWith(spinner);

        %{--var dsps=${obra.distanciaPeso}--}%
        %{--var dsvs=${obra.distanciaVolumen}--}%
        %{--var volqueta=${precioVol}--}%
        %{--var chofer=${precioChof}--}%

        %{--var url = "${g.createLink(controller: 'reportes', action: 'reporteExcelVolObra')}"--}%

        $("#dlgLoad").dialog("open");

        $.ajax( {

            type: 'POST',
            url: "${g.createLink(controller: 'reportes',action: 'reporteExcelVolObra')}",
            data:{

                id:'${obra?.id}'

            },
            success: function (msg) {
               location.href = "${g.createLink(controller: 'reportes',action: 'reporteExcelVolObra',id: obra?.id)}";
                $("#dlgLoad").dialog("close");

//                spinner.replaceWith($boton);

            }



        });



    });

    $("#subPres_desc").change(function(){
        $("#ver_todos").removeClass("active")
        $("#divTotal").html("")
        $("#calcular").removeClass("active")

        var datos = "obra=${obra.id}&sub="+$("#subPres_desc").val()+"&ord=" + 1


        var interval = loading("detalle")
        $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'tabla')}",
            data     : datos,
            success  : function (msg) {
                clearInterval(interval)
                $("#detalle").html(msg)
            }
        });
    });

    $("#ver_todos").click(function(){
        $("#calcular").removeClass("active")
        $("#divTotal").html("")
        if ($(this).hasClass("active")) {
            $(this).removeClass("active")

            var datos = "obra=${obra.id}&sub="+$("#subPres_desc").val()
            var interval = loading("detalle")
            $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'tabla')}",
                data     : datos,
                success  : function (msg) {
                    clearInterval(interval)
                    $("#detalle").html(msg)
                }
            });

        }else{
            $(this).addClass("active")
            var datos = "obra=${obra.id}"
            var interval = loading("detalle")
            $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'tabla')}",
                data     : datos,
                success  : function (msg) {
                    clearInterval(interval)
                    $("#detalle").html(msg)
                }
            });
        }
        return false

    }) ;
                var datos = "?fecha=${obra.fechaPreciosRubros?.format('dd-MM-yyyy')}Wid="+$(".item_row").attr("id") +"Wobra=${obra.id}" +


    $(".item_row").dblclick(function(){
        $("#calcular").removeClass("active")
        $(".col_delete").show()
        $(".col_precio").hide()
        $(".col_total").hide()
        $("#divTotal").html("")
        $("#vol_id").val($(this).attr("id"))
        $("#item_codigo").val($(this).find(".cdgo").html())
        $("#item_id").val($(this).attr("item"))
        $("#subPres").val($(this).attr("sub"))
        $("#item_nombre").val($(this).find(".nombre").html())
        $("#item_cantidad").val($(this).find(".cant").html().toString().trim())
        $("#item_orden").val($(this).find(".orden").html() )

    });
    $(".borrarItem").click(function(){

        var interval = loading("detalle")

        if(confirm("Esta seguro de eliminar el rubro?")){
            $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'eliminarRubro')}",
                data     : "id=" + $(this).attr("iden"),
                success  : function (msg) {
                    clearInterval(interval)
                    $("#detalle").html(msg)

                }
            });
        }
    });

$("#copiar_rubros").click(function () {


    location.href="${createLink(controller: 'volumenObra', action: 'copiarRubros', id: obra?.id)}?obra=" + ${obra?.id}

});

 $("#ordenarAsc").click(function () {

     $("#ver_todos").removeClass("active")
     $("#divTotal").html("")
     $("#calcular").removeClass("active")

     var orden = 1;

     var datos = "obra=${obra.id}&sub="+$("#subPres_desc").val() + "&ord=" + orden


     var interval = loading("detalle")
     $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'tabla')}",
         data     : datos,
         success  : function (msg) {
             clearInterval(interval)
             $("#detalle").html(msg)
         }
     });

 });

 $("#ordenarDesc").click(function () {

     $("#ver_todos").removeClass("active")
     $("#divTotal").html("")
     $("#calcular").removeClass("active")

     var orden = 2;

     var datos = "obra=${obra.id}&sub="+$("#subPres_desc").val() + "&ord=" + orden


     var interval = loading("detalle")
     $.ajax({type : "POST", url : "${g.createLink(controller: 'volumenObra',action:'tabla')}",
         data     : datos,
         success  : function (msg) {
             clearInterval(interval)
             $("#detalle").html(msg)
         }
     });

 });



    $("#desgloseDialog").dialog({

        autoOpen  : false,
        resizable : false,
        modal     : true,
        draggable : false,
        width     : 350,
        height    : 150,
        position  : 'center',
        title     : 'Imprimir con desglose de transporte',
        buttons   : {
            "Si" : function () {


                var dsps=${obra.distanciaPeso}
                var dsvs=${obra.distanciaVolumen}
                var volqueta=${precioVol}
                var chofer=${precioChof}
                var datos = "?fecha=${obra.fechaPreciosRubros?.format('dd-MM-yyyy')}Wid="+$(".item_row").attr("id") +"Wobra=${obra.id}" + "Wdesglose=${1}"

                var url = "${g.createLink(controller: 'reportes3',action: 'imprimirRubroVolObra')}"+datos
                location.href="${g.createLink(controller: 'pdf',action: 'pdfLink')}?url="+url



                $("#desgloseDialog").dialog("close");

            },
            "No" : function () {



                var dsps=${obra.distanciaPeso}
                var dsvs=${obra.distanciaVolumen}
                var volqueta=${precioVol}
                var chofer=${precioChof}
                var datos = "?fecha=${obra.fechaPreciosRubros?.format('dd-MM-yyyy')}Wid="+$(".item_row").attr("id") +"Wobra=${obra.id}"

                var url = "${g.createLink(controller: 'reportes3',action: 'imprimirRubroVolObra')}"+datos
                location.href="${g.createLink(controller: 'pdf',action: 'pdfLink')}?url="+url




                $("#desgloseDialog").dialog("close");

            }
        }


    });





</script>