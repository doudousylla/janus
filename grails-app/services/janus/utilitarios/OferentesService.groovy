package janus.utilitarios
import org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsDomainBinder
class OferentesService {

    def dbConnectionService
    def grailsApplication

    def exportDominio(dominio,campoReferencia,objeto){
//        println "dom "+dominio+" camp "+campoReferencia+"  obt "+objeto
        def sql = "insert into % & values # "
        def campos ="("
        def valores ="("
        def dc = grailsApplication.getDomainClass(dominio.toString().split(" ")[1])
        def mapa =  GrailsDomainBinder.getMapping(dominio)
        def tabla=mapa.table.name
        def validacion ="select count(*) from ${tabla} where ${campoReferencia}=${objeto.id}"
        mapa.columns.eachWithIndex {c,i->
//            println "it "+c.key+" "+c.value.type+"  "+c.value.getColumn()
//            print " "+c.key+" "+c.value.getColumn()+" ====> "
            campos+=""+c.value.getColumn()
            if (i<mapa.columns.size()-1){
                campos+=","
            }
            def p = dc.properties.find {prop->
                prop.name==c.key
            }
            valores+=""+campoASql(p,objeto)
            if (i<mapa.columns.size()-1){
                valores+=","
            }

        }

        campos+=",${campoReferencia})"
        valores+=",${objeto.id})"
//        println "campos "+campos
//        println "valores "+valores
        sql = sql.replace("%",tabla)
        sql = sql.replace("&",campos)
        sql = sql.replace("#",valores)
//        println "sql "+sql
        def cn = dbConnectionService.getConnectionOferentes()
        def count=0
//        println "validacion "+validacion
        cn.eachRow(validacion.toString()){r->
//            println "r "+r
            count=r[0]
        }
        if (count==0){
            def res
            try{
                res = cn.execute(sql.toString())
            }catch (e){
                res = true
            }
            cn.close()
            return !res
        }else{
            cn.close()
            return -1
        }

    }

    String campoASql(campo,obj){

        def sql =""
        def tipo = campo.getType()
//      println "  campo "+campo.name+" tipo "+tipo+" valor  "+obj.properties[campo.name]
        if (campo.name=="id"){
            sql+="default"
            return sql
        }

        if (obj.properties[campo.name]){
            if (tipo=~"String"){
                sql+="'"+obj.properties[campo.name]+"'"
            }else{
                if (tipo=~"Date"){
                    sql+="'"+obj.properties[campo.name].format("yyyy-MM-dd hh:mm:ss")+"'"
                } else{
                    if (tipo=~"janus"){
                        sql+=""+obj.properties[campo.name].id
                    }else{
                        sql+=""+obj.properties[campo.name]
                    }
                }
            }
        }else{
            sql+="null"
        }
//      println "fin funcion "+sql
        return sql

    }

}
