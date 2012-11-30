package janus

class VolumenObraController extends janus.seguridad.Shield{
    def buscadorService
    def preciosService
    def volObra(){

        def obra = Obra.get(1)
        def volumenes = VolumenesObra.findAllByObra(obra)
        def subPres = volumenes.subPresupuesto
        def campos = ["codigo": ["Código", "string"], "nombre": ["Descripción", "string"]]

        [obra:obra,volumenes:volumenes,subPres:subPres,campos:campos]



    }

    def addItem(){
        println "addItem "+params
        def obra= Obra.get(params.obra)
        def rubro = Item.get(params.rubro)
        def volumen
        if (params.id)
            volumen=VolumenesObra.get(params.id)
        else
            volumen=new VolumenesObra()
        volumen.cantidad=params.cantidad.toDouble()
        volumen.orden=params.orden.toInteger()
        volumen.subPresupuesto=SubPresupuesto.get(params.sub)
        volumen.obra=obra
        volumen.item=rubro
        preciosService.actualizaOrden(obra,volumen.orden)
        if (!volumen.save(flush: true)){
            println "error volumen obra "+volumen.errors
            render "error"
        }else{
            redirect(action: "tabla",params: [obra:obra.id])
        }
    }

    def tabla(){
        def obra = Obra.get(params.obra)
        def detalle
        if (params.sub)
            detalle= VolumenesObra.findAllByObraAndSubPresupuesto(obra,SubPresupuesto.get(params.sub))
        else
            detalle= VolumenesObra.findAllByObra(obra)


        def fecha = obra.fechaPreciosRubros
        def dpsp = obra.distanciaPeso
        def dsvs = obra.distanciaVolumen
        def prch = obra.itemChofer
        def prvl = obra.itemPorVolquete
        def rendimientos = preciosService.rendimientoTranposrte(params.dsps.toDouble(),params.dsvs.toDouble(),params.prch.toDouble(),params.prvl.toDouble())
        println "rends "+rendimientos
        if (rendimientos["rdps"].toString()=="NaN")
            rendimientos["rdps"]=0
        if (rendimientos["rdvl"].toString()=="NaN")
            rendimientos["rdvl"]=0
        def parametros = ""+idRubro+","+params.lugar+",'"+fecha.format("yyyy-MM-dd")+"',"+params.dsps.toDouble()+","+params.dsvs.toDouble()+","+rendimientos["rdps"]+","+rendimientos["rdvl"]
        def res = preciosService.rb_precios(parametros,"")



        [detalle:detalle]

    }

    def eliminarRubro(){
        def vol = VolumenesObra.get(params.id)
        def obra = vol.obra
        def orden = vol.orden
        vol.delete()
        preciosService.actualizaOrden(obra,orden)
        redirect(action: "tabla",params: [obra:obra.id])

    }

    def buscaRubro() {

        def listaTitulos = ["Código", "Descripción"]
        def listaCampos = ["codigo", "nombre"]
        def funciones = [null, null]
        def url = g.createLink(action: "buscaRubro", controller: "rubro")
        def funcionJs = "function(){"
        funcionJs += '$("#modal-rubro").modal("hide");'
        funcionJs += '$("#item_id").val($(this).attr("regId"));$("#item_codigo").val($(this).attr("prop_codigo"));$("#item_nombre").val($(this).attr("prop_nombre"))'
        funcionJs += '}'
        def numRegistros = 20
        def extras = " and tipoItem = 2"
        if (!params.reporte) {
            def lista = buscadorService.buscar(Item, "Item", "excluyente", params, true, extras) /* Dominio, nombre del dominio , excluyente o incluyente ,params tal cual llegan de la interfaz del buscador, ignore case */
            lista.pop()
            render(view: '../tablaBuscador', model: [listaTitulos: listaTitulos, listaCampos: listaCampos, lista: lista, funciones: funciones, url: url, controller: "llamada", numRegistros: numRegistros, funcionJs: funcionJs])
        } else {
            println "entro reporte"
            /*De esto solo cambiar el dominio, el parametro tabla, el paramtero titulo y el tamaño de las columnas (anchos)*/
            session.dominio = Item
            session.funciones = funciones
            def anchos = [20, 80] /*el ancho de las columnas en porcentajes... solo enteros*/
            redirect(controller: "reportes", action: "reporteBuscador", params: [listaCampos: listaCampos, listaTitulos: listaTitulos, tabla: "Item", orden: params.orden, ordenado: params.ordenado, criterios: params.criterios, operadores: params.operadores, campos: params.campos, titulo: "Rubros", anchos: anchos, extras: extras, landscape: true])
        }
    }
}
