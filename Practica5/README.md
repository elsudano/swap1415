Practica 5 <img src="basedatos.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Replicando servidores completos de Base de Datos*

### Objetivos
En esta practica lo que se pretende es conseguir crear una copia casi exacta de un servidor de base de datos, pero tambien se pretende que el servicio no se detenga mientras sucede esto, es decir, que podamos tener la información disponible en todo momento mientras tenemos la seguridad de que nuestros datos estan a salvo en otro servidor identico.

### Pasos realizados
> * Paso 1 <br />
> La primera parte de la practica es configurar correctamente el servidor MySQL <br />
> * Paso 2 <br />
> Preparamos las diferentes tablas que nos van a hacer falta para poder tomar las mediciones, ya que hay 9 escenarios diferentes de los cuales tenemos que tomar medidas. <br />
> * Paso 3 <br />
> Para hacernos una idea de lo que hay que apuntar en las tablas hacemos unas pruebas con los 3 programas que utilizaremos para realizar las mediciones y miramos los parámetros que nos devuelven después de ejecutarlos y esos serás los que pongamos en las tablas. <br />
> * Paso 4 <br />
> Pasamos ha realizar la batería de los diferentes test que necesitamos. Seguiremos el orden AB, HTTPERF, OPENWEBLOAD <br />
> * Paso 5 <br />
> Por último generamos las gráficas resultantes de las mediciones realizadas. <br />

```bash
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
```
### Conclusiones
Incluso con servidores virtuales si la granja tiene una buena infraestructura de red, puede dar un servicio muy aceptable en el momento que se introduce el concepto de balanceo de carga.
También quiero indicar que después de haber probado los tres programas de test para la granja web he de decir que el que mas recursos consume realizando los test es el httperf,
y la verdad que los resultados que devuelve no son muy útiles