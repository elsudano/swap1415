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
 * El segundo se encarga de realizar una copia de seguridad de la base de datos que hemos creado antes. <br />
 * Por último el tercero es el encargado de restaurar esa copia de seguridad en el segundo servidor (DB2). <br />
```bash
#!/bin/bash
echo .
echo .  Primero creamos la Base de datos
echo .  mysql --host=localhost --user=root --password=contraseña --execute=\"create database contactos\"
echo .
echo .
echo . Despues miramos las tablas de la base de datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" contactos
echo .
echo .
echo . Como vemos no tienen ninguna tabla, así que vamos a crear una que se llame datos
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"create table datos \(nombre varchar\(100\), tlf int\)\" contactos
echo .
echo .
echo . Volvemos a comprobar las tablas que tenemos creadas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"show tables\" contactos
echo .
echo .
echo . Esta vez si obtenemos resultados positivos
echo .
echo . Ahora vamos a insertar algunos registros para poder realizar las pruebas
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"insert into datos\(nombre,tlf\) values \(\"pepe\",95834987\)\" contactos
echo . repetiremos esta operación tantas veces como registros queramos crear
echo .
echo . Y después de haber metido los registros miramos si estan correctamente insertados
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"select \* from datos\" contactos
echo . como vemos a continuación tenemos 4 registros insertados
echo .
echo .
echo . Por ultimo vamos a usar el siguiente comando para ver la estructura de la tabla
echo . mysql --host=localhost --user=root --password=contraseña --execute=\"describe datos\" contactos
echo .
echo . Por ultimo damos la posibilidad de borrar la base de datos
echo .
read -p " ¿ quiere borrar la BD contactos ? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
```
### Conclusiones
Incluso con servidores virtuales si la granja tiene una buena infraestructura de red, puede dar un servicio muy aceptable en el momento que se introduce el concepto de balanceo de carga.
También quiero indicar que después de haber probado los tres programas de test para la granja web he de decir que el que mas recursos consume realizando los test es el httperf,
y la verdad que los resultados que devuelve no son muy útiles