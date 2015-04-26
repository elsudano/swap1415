Practica 6 <img src="RAID01.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Replicando datos en dos discos duros*

### Objetivos
En esta práctica configuraremos dos discos en RAID 1 por software, usando una
maquina virtual con Centos 7.1. Esta configuración RAID ofrece una gran
seguridad al replicar los datos en los dos discos.


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


### Configuración Manual
Hasta aquí hemos conseguido que la replicación de datos sea consistente pero bastante primitiva, puesto que necesitamos de tareas programadas para que se realice el proceso o bien a un técnico que se encargue de monitorizar la copia de datos entre los dos servidores. <br />
Lo que vamos a intentar ahora es configurar los dos servidores para que actúen como maestro/esclavo, (DB1/DB2), para que la replica de datos sea casi automática. <br />

### Configuración Maestro/Maestro
Ya hemos visto que se pueden hacer copia de los datos entre servidores, de forma rudimentaria, ahora vamos a realizarlo de manera un poco mas profesional y sin tener que programar tareas para que el replicado de datos se lleve a cabo, sino que se guardaran los datos en los dos servidores simultáneamente.<br />
La metodología para configurar de esta manera los servidores es bastante sencilla, lo que se hace es configurar un servidor primero como maestro DB1 y el segundo se configura como esclavo DB2, a continuación se realiza la misma operación pero en el otros sentido, así de esa manera, si cualquiera de los dos servidores se estropeara, bastaría con sustituirlo por una maquina nueva y ponerle la misma IP que el servidor que se ha estropeado, de esa manera, una vez configurado correctamente el nuevo servidor se auto replicarían los datos de un servidor a otro.<br />

**Fichero de configuración en DB1**
```bash
[usuario@DB1 /]# cat /etc/my.cnf
# bind-address          = 127.0.0.1
server-id               = 1 # identificador del servidor
report_host             = 192.168.50.159 # ip del servidor cuando actúa como esclavo
log_bin                 = /var/log/mariadb/mariadb-bin 
log_bin_index           = /var/log/mariadb/mariadb-bin.index
relay_log               = /var/log/mariadb/relay-bin
relay_log_index         = /var/log/mariadb/relay-bin.index
replicate-do-db         = contactos # solo se replicará esta base de datos
...
[usuario@DB1 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="create user 'replicauser'@'%' identified by 'contraseña'"
[usuario@DB1 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="grant replication slave on *.* to 'replicauser'@'%'"
```

<pre><code>
[usuario@DB2 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="stop slave"
[usuario@DB2 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="change master to master_host='<b>192.168.50.159</b>', MASTER_USER='replicauser', MASTER_PASSWORD='contraseña', MASTER_LOG_FILE='mariadb-bin.000001', MASTER_LOG_POS=245"
[usuario@DB2 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="start slave"
[usuario@DB2 /]# mysql --host=localhost --user=root --password=contraseña --database="contactos" --execute="unlock tables"
</code></pre>

### Bibliografía
> Página web de MariaDB: https://mariadb.com/kb/en/mariadb/replication-cluster-multi-master/ <br />
> Comandos mas usados: https://mariadb.com/kb/en/mariadb/replication-commands/ <br />
> Parametros de configuración de replica: https://mariadb.com/kb/en/mariadb/replication-and-binary-log-server-system-variables/ <br />

### Conclusiones
Bueno la primera parte de la practica, se supone que es mas fácil por que es algo que ya hemos visto en las anteriores, aun así hay que tener cuidado a la hora de utilizar los comandos de copia entre servidores para clonar las configuraciones de ambos por que, si no vamos con cuidado podemos copiar la configuración mala, en el servidor con la configuración buena.<br />
Aparte de eso es bastante sencillo poder crear una copia del servidor completo por si al maestro le sucediera algo. Después la segunda parte de la practica se complica un poco mas, pero esta claro que es la configuración que tenemos que realizar para cuando tenemos servidores en producción, puesto que de esta forma no bloqueamos la inserción de datos mientras estamos realizando una copia de seguridad en el otro servidor, pero claro que esto también tiene la pega, de que si nos equivocamos, y borramos registros sin querer hacerlo, también se borran en el otros servidor, por lo tanto hay que tener claro que aunque tengamos, replicados los datos para posibles contingencias frente a fallos, también hay que realizar copias de seguridad programadas.