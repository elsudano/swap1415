#!/bin/bash
echo .
echo .  Primero creamos la Base de datos
echo .  mysql --host=localhost --user=root --password=contraseña --execute=\"create database contactos\"
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="create database contactos"
echo .
echo . Despues miramos las tablas de la base de datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" contactos
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="show tables" contactos
echo .
echo . Como vemos no tienen ninguna tabla, así que vamos a crear una que se llame datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"create table datos \(nombre varchar\(100\), tlf int\)\" contactos
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="create table datos (nombre varchar(100), tlf int)" contactos
echo .
echo . Volvemos a comprobar las tablas que tenemos creadas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" contactos
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="show tables" contactos
echo .
echo . Esta vez si obtenemos resultados positivos
echo .
echo . Ahora vamos a insertar algunos registros para poder realizar las pruebas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"insert into datos\(nombre,tlf\) values \(\"pepe\",95834987\)\" contactos
echo . repetiremos esta operación tantas veces como registros queramos crear
mysql --host=localhost --user=root --password=p1tr3l1 --execute="insert into datos (nombre,tlf) values ('pepe',958123456)" contactos
mysql --host=localhost --user=root --password=p1tr3l1 --execute="insert into datos (nombre,tlf) values ('juan',958654321)" contactos
mysql --host=localhost --user=root --password=p1tr3l1 --execute="insert into datos (nombre,tlf) values ('carlos',958987654)" contactos
mysql --host=localhost --user=root --password=p1tr3l1 --execute="insert into datos (nombre,tlf) values ('pedro',958456789)" contactos
echo .
echo . Y después de haber metido los registros miramos si estan correctamente insertados
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"select \* from datos\" contactos
echo . como vemos a continuación tenemos 4 registros insertados
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="select * from datos" contactos
echo .
echo . Por ultimo vamos a usar el siguiente comando para ver la estructura de la tabla
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"describe datos\" contactos
echo .
mysql --host=localhost --user=root --password=p1tr3l1 --execute="describe datos" contactos
echo . Por ultimo damos la posibilidad de borrar la base de datos
echo .
read -p " ¿ quiere borrar la BD contactos ? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
mysql --host=localhost --user=root --password=p1tr3l1 --execute="DROP DATABASE contactos"