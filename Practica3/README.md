Practica 3 <img src="nginx.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Configurando Nginx y HaProxy como balanceadores de carga*

### Objetivos
En esta practica se pretende simular un granja web con un balanceador de carga y dos servidores finales, que aunque sean dos maquinas iguales, configuraremos la primera como si tuviera el doble de capacidad que la segunda.

### Pasos realizados
> * Paso 1
> > Lo primero que realice fue la configuración de una de las maquinas servidoras de paginas web, con todos los parámetros relevantes en un servidor apache.
> * Paso 2
> > El siguiente paso fue instalar PHP, y preparar el servidor para que se pudiera utilizar phpMyAdmin para gestionar las bases de datos. De momento configure una base de datos local para poder realizar la configuración del servidor.
> * Paso 3
> > Después clone la maquina resultado para poder tener las dos maquinas que me servirían las paginas web de mi granja, por supuesto tuve que realizar algunos cambios en la configuración de la segunda maquina para que no hubiera conflictos de IP ni de resolución de nombres.
> * Paso 4
> > Una vez que ya tenia las maquinas listas prepare una tercera maquina que seria la que nos serviría de de balanceador de carga, en esta maquina instalé nginx y haproxy, con sus ficheros de configuración

### Conclusiones
Esta claro que los comando que se han explicado en el párrafo anterior también son aplicables al segundo servidor, por supuesto hay que tener claro como queremos que se repliquen los datos, puesto que si tenemos uno como maestro, y otro como esclavo, tenemos que tener en cuenta esa topología, ahora bien si queremos que ambos servidores sean maestros, tendremos que reproducir todos los comandos incluso los del cron. 
