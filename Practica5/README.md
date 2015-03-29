Practica 5 <img src="basedatos.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Replicando servidores completos de Base de Datos*

### Objetivos
En esta practica lo que se pretende es conseguir crear una copia casi exacta de un servidor de base de datos, pero tambien se pretende que el servicio no se detenga mientras sucede esto, es decir, que podamos tener la información disponible en todo momento mientras tenemos la seguridad de que nuestros datos estan a salvo en otro servidor identico.

### Pasos realizados
> * Paso 1 <br />
> La primera parte de la practica es configurar correctamente el servidor MySQL <br />
> * Paso 2 <br />
> Para que sea mas fácil de gestionar la base de datos he instalado Apache y phpMyAdmin para la comprobación de las sentencias ejecutadas desde la consola. <br />
> * Paso 3 <br />
> Para no tener que preocuparme de la configuración de estos dos servicios instalados en los dos servidores, creo una tarea programada en el servidor "copia" DB2 que se encarga de tener sincronizada la configuración, de ambos servicios. <br />
> * Paso 4 <br />
> Creo los scripts necesarios para comprobar que todos los comandos se pueden realizar sin problemas, entre los dos servidores, de esa manera me aseguro tener los datos preparados para poder ejecutarlos a mano. <br />
> * Paso 5 <br />
> . <br />

### Scripts Adicionales
Los siguientes scripts, sirven de ayuda a la gestión de los servidores replicados, se ha procurado crear los scripts necesarios tanto para la creación desde cero de las bases de datos, las tablas y los datos necesarios para la realización de la practica. <br />
 * El primero de todos se encarga de crear la base de datos, la tabla y los registros necesarios para realizar la practica. <br />
 * El segundo se encarga de realizar una copia de seguridad de la base de datos que hemos creado antes en DB1 y copiarlo al segundo servidor. <br />
 * Por último el tercero es el encargado de restaurar esa copia de seguridad en el segundo servidor (DB2) y borrar el fichero de copia. <br />

**config_manual.sh**
```bash
#!/bin/bash
echo .
echo .  Primero creamos la Base de datos
echo .  mysql --host=localhost --user=root --password=contraseña --execute=\"CREATE DATABASE IF NOT EXISTS contactos\"
echo .
echo .
echo . Despues miramos las tablas de la base de datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" --database=\"contactos\"
echo .
echo .
echo . Como vemos no tienen ninguna tabla, así que vamos a crear una que se llame datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"create table if not exists datos \(nombre varchar\(100\), tlf int\)\" --database=\"contactos\"
echo .
echo .
echo . Volvemos a comprobar las tablas que tenemos creadas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" --database=\"contactos\"
echo .
echo .
echo . Esta vez si obtenemos resultados positivos
echo .
echo . Ahora vamos a insertar algunos registros para poder realizar las pruebas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"insert into datos\(nombre,tlf\) values \(\"pepe\",95834987\)\" --database=\"contactos\"
echo . repetiremos esta operación tantas veces como registros queramos crear
echo .
echo . Y después de haber metido los registros miramos si estan correctamente insertados
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"select \* from datos\" --database=\"contactos\"
echo . como vemos a continuación tenemos 4 registros insertados
echo .
echo .
echo . Por ultimo vamos a usar el siguiente comando para ver la estructura de la tabla
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"describe datos\" --database=\"contactos\"
echo .
echo . Por ultimo damos la posibilidad de borrar la base de datos
echo .
read -p " ¿ quiere borrar la BD contactos ? " -n 1 -r
echo
```

**realizar_copia.sh**
```bash
#!/bin/bash
echo .
echo .  Para poder crear la copia de seguridad tenemos que asegurarnos que no se añaden mas registros mientras la hacemos
echo .  mysql --host=localhost --user=root --password=contraseña --database=\"contactos\" --execute=\"FLUSH TABLES WITH READ LOCK\"
echo .
echo .
echo . Ahora realizamos la copia de seguridad y la guardamos en un fichero con extención .sql
echo . mysqldump --host=localhost --user=root --password=contraseña contactos datos \> /home/usuario/copia_seguridad_db1.sql
echo .
echo .
echo . Una vez que se ha creado el fichero con el volcado de la tabla tenemos que volver su estado normal la base de datos
echo . mysql --host=localhost --user=root --password=contraseña --database=\"contactos\" --execute=\"UNLOCK TABLES\"
echo .
echo . Por ultimo damos la posibilidad de copiar la copia al segundo servidor.
echo .
read -p " ¿ quiere copiar el fichero al segundo servidor DB2 ? " -n 1 -r
echo
```
**restaturar_copia.sh**
```bash
#!/bin/bash
echo .
echo .  Para restaurar los datos de una base de datos primero, esa base de datos tiene que existir.
echo .  mysql --host=localhost --user=root --password=contraseña --execute=\"CREATE DATABASE IF NOT EXISTS contactos\"
echo .
echo .
echo . Ahora que ya sabemos seguro que la base de datos existe tenemos que recuperar los datos
echo . mysql --host=localhost --user=root --password=contraseña --database=\"contactos\" --table=\"datos\" \< /home/usuario/copia_seguridad_db1.sql
echo .
echo .
echo . Ahora comprobamos que los datos se han recuperado correctamente
echo . mysql --host=localhost --user=root --password=contraseña --database=\"contactos\" --execute="select * from datos" contactos
echo .
echo . Por ultimo damos la posibilidad de borrar el fichero de copia de seguridad.
echo .
read -p " ¿ quiere borrar copia_seguridad_db1.sql ? " -n 1 -r
echo
```
### Conclusiones
Incluso con servidores virtuales si la granja tiene una buena infraestructura de red, puede dar un servicio muy aceptable en el momento que se introduce el concepto de balanceo de carga.
También quiero indicar que después de haber probado los tres programas de test para la granja web he de decir que el que mas recursos consume realizando los test es el httperf,
y la verdad que los resultados que devuelve no son muy útiles