dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    dialect = org.hibernate.dialect.PostgreSQLDialect
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://192.168.100.9:5432/janus_prba"
//            url = "jdbc:postgresql://192.168.100.9:5432/janus_prba1"   //probar suspoensiones de cntr:36 id:79
//            url = "jdbc:postgresql://192.168.100.9:5432/cnsl_prba"
//            url = "jdbc:postgresql://192.168.100.9:5432/cnsl_prba2"
            username = "postgres"
            password = "postgres"
        }
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            username = 'postgres'
            password = 'postgres'
//            url = 'jdbc:postgresql://127.0.0.1:5432/oferentes'
            url = 'jdbc:postgresql://192.168.100.9:5432/oferentes_prba'
            dbCreate = 'update'
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://10.0.0.3:5432/janus2"
            username = "postgres"
            password = "postgres"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://127.0.0.1:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/gadpp"
            username = "postgres"
            password = "janus"
        }
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            url = "jdbc:postgresql://127.0.0.1:5432/oferentes"
            username = "postgres"
            password = "janus"
            dbCreate = 'update'
        }
    }

    produccionGADPP {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://127.0.0.1:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/obras"
            username = "postgres"
            password = "janus"
        }
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            url = "jdbc:postgresql://127.0.0.1:5432/oferentes"
            username = "postgres"
            password = "janus"
            dbCreate = 'update'
        }
    }

    consultoria {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://127.0.0.1:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/consultoria"
            username = "postgres"
            password = "janus"
        }
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            url = "jdbc:postgresql://127.0.0.1:5432/oferentes"
            username = "postgres"
            password = "janus"
            dbCreate = 'update'
        }
    }
    pruebas {
        dataSource {
            dbCreate = "update"
            //url = "jdbc:postgresql://127.0.0.1:5432/janus"
            url = "jdbc:postgresql://127.0.0.1:5432/janus_prueba"
            username = "postgres"
            password = "janus"
        }
        dataSource_oferentes {
            dialect = org.hibernate.dialect.PostgreSQLDialect
            driverClassName = 'org.postgresql.Driver'
            url = "jdbc:postgresql://127.0.0.1:5432/oferentes"
            username = "postgres"
            password = "janus"
            dbCreate = 'update'
        }
    }

}
