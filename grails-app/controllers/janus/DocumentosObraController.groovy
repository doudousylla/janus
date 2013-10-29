package janus

import groovy.json.JsonBuilder

class DocumentosObraController {

    def index() { }


    def preciosService


    def documentosObra () {

        println("params:" + params)

        def pr = janus.ReportesController

        def nota = new Nota();

        def auxiliar = new Auxiliar();

        def auxiliarFijo = Auxiliar.get(1);

        def usuario = session.usuario.id

        def persona = Persona.get(usuario)

//        println(params)

        def obra = Obra.get(params.id)

//        def cuadrilla = FormulaPolinomica.findAllByObraAndNumeroIlike(obra,'c%')

//        println("cuadrilla:" + cuadrilla)

        def departamento = Departamento.get(obra?.departamento?.id)

//        println("departamento: " + obra?.departamento?.id)

        def personas = Persona.list()

        def departamentos = Departamento.list()

       //totalPresupuesto

        def detalle

        detalle= VolumenesObra.findAllByObra(obra,[sort:"orden"])


        def precios = [:]
        def fecha = obra.fechaPreciosRubros
        def dsps = obra.distanciaPeso
        def dsvl = obra.distanciaVolumen
        def lugar = obra.lugar


        def prch = 0
        def prvl = 0

        if (obra.chofer){
            prch = preciosService.getPrecioItems(fecha,lugar,[obra.chofer])
            prch = prch["${obra.chofer.id}"]
            prvl = preciosService.getPrecioItems(fecha,lugar,[obra.volquete])
            prvl = prvl["${obra.volquete.id}"]
        }
        def indirecto = obra.totales/100


        def total1 = 0;
        def total2 = 0;
        def totalPrueba = 0

        def totales

        def totalPresupuesto=0;
        def totalPresupuestoBien=0;

        def valores = preciosService.rbro_pcun_v2(obra.id)

        def subPres = VolumenesObra.findAllByObra(obra,[sort:"orden"]).subPresupuesto.unique()


        subPres.each { s->

            total2 = 0

            valores.each {

              if(it.sbprdscr == s.descripcion){

                totales = it.totl
                totalPresupuestoBien = (total1 += totales)
                totalPrueba = total2 += totales

              }
            }

        }

        detalle.each {

            def res = preciosService.precioUnitarioVolumenObraSinOrderBy("sum(parcial)+sum(parcial_t) precio ",obra.id,it.item.id)
            precios.put(it.id.toString(),(res["precio"][0]+res["precio"][0]*indirecto).toDouble().round(2))


            totales =  precios[it.id.toString()]*it.cantidad


            totalPresupuesto+=totales;

        }



        def firmasAdicionales = Persona.findAllByDepartamento(departamento)


        def funcionFirmar = Funcion.get(2)

        def funcionDirector = Funcion.get(9)


        def direccion = departamento.direccion

        def dptoDireccion = Departamento.findAllByDireccion(direccion)

        def personalDireccion = Persona.findAllByDepartamentoInList(dptoDireccion, [sort: 'nombre'])


        def firmas = PersonaRol.findAllByFuncionAndPersonaInList(funcionFirmar, firmasAdicionales)

        def firmaDirector = PersonaRol.findByFuncionAndPersonaInList(funcionDirector, personalDireccion)


//        println("Director-->" + firmaDirector)

        //calculo de composición

        def resComp = Composicion.findAll("from Composicion where obra=${params.id} and grupo in (${1})")
        resComp.sort{it.item.codigo}

        def resMano = Composicion.findAll("from Composicion where obra=${params.id} and grupo in (${2})")
        resMano.sort{it.item.codigo}


        def resEq = Composicion.findAll("from Composicion where obra=${params.id} and grupo in (${3})")
        resEq.sort{it.item.codigo}

        [obra: obra, nota: nota, auxiliar: auxiliar, auxiliarFijo: auxiliarFijo, totalPresupuesto: totalPresupuesto, firmas: firmas.persona,
                totalPresupuestoBien: totalPresupuestoBien, persona: persona, resComp: resComp, resMano: resMano, resEq: resEq, firmaDirector: firmaDirector]



    }


    def getDatos () {

        def nota = Nota.get(params.id)


        def map
        if (nota) {
            map=[
                    id: nota.id,
                    descripcion: nota.descripcion?:"",
                    texto: nota.texto,
                    adicional:nota.adicional?:""
            ]
        } else {

            map=[
                    id: "",
                    descripcion: "",
                    texto: "",
                    adicional:""
            ]
        }
        def json = new JsonBuilder( map)

        render json
    }

}
