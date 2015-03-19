Practica 4 <img src="apache.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Realizando mediciones para comprobar el rendimiento*

### Objetivos
En esta practica vamos a comprobar el rendimiento que tiene nuestra granja web, para ello utilizaremos tres programas diferentes para realizar test de diferentes tipos de estrés para nuestra granja.

### Pasos realizados

<br />

### Tablas de Valores
|                                              SERVIDOR WEB                                           |
|----------------------|--------------------|---------|---------|---------------------|---------------| 
|                      |           Tiempo de Conexión           |       Tiempo de Respuesta           | 
|                      | Mínimo             | Media   | Máximo  | Respuesta           | Transferencia | 
| Medición 1:          | 0,50               | 1,00    | 13,10   | 0,60                | 0,20          | 
| Medición 2:          | 0,50               | 0,90    | 16,00   | 0,50                | 0,20          | 
| Medición 3:          | 0,50               | 0,90    | 15,90   | 0,50                | 0,20          | 
| Medición 4:          | 0,50               | 1,00    | 13,10   | 0,50                | 0,20          | 
| Medición 5:          | 0,60               | 0,80    | 15,40   | 0,50                | 0,20          | 
| Medición 6:          | 0,60               | 0,90    | 15,00   | 0,60                | 0,20          | 
| Medición 7:          | 0,50               | 70,30   | 100,50  | 0,50                | 0,20          | 
| Medición 8:          | 0,60               | 0,80    | 15,40   | 0,50                | 0,20          | 
| Medición 9:          | 0,60               | 0,90    | 18,30   | 0,50                | 0,20          | 
| Medición 10:         | 0,60               | 0,90    | 15,00   | 0,50                | 0,20          | 
| Media:               | 0,55               | 7,84    | 23,77   | 0,52                | 0,20          | 
| Desviación:          | 0,05               | 21,95   | 27,00   | 0,04                | 0,00          | 
|                      |                    |         |         |                     |               | 
|                                  BALANCEADOR DE CARGA                                               | 
|                      |             Tiempo de Conexión         |        Tiempo de Respuesta          | 
|                      | Mínimo             | Media   | Máximo  | Respuesta           | Transferencia | 
| Medición 1:          |                    |         |         |                     |               | 
| Medición 2:          |                    |         |         |                     |               | 
| Medición 3:          |                    |         |         |                     |               | 
| Medición 4:          |                    |         |         |                     |               | 
| Medición 5:          |                    |         |         |                     |               | 
| Medición 6:          |                    |         |         |                     |               | 
| Medición 7:          |                    |         |         |                     |               | 
| Medición 8:          |                    |         |         |                     |               | 
| Medición 9:          |                    |         |         |                     |               | 
| Medición 10:         |                    |         |         |                     |               | 
| Media:               |                    |         |         |                     |               | 
| Desviación:          |                    |         |         |                     |               |
|----------------------|--------------------|---------|---------|---------------------|---------------|

### Gráficas
Las gráficas que se muestran a continuación llevan el mismo orden que las tablas anteriores <br />
<img src="screenshoot3.jpg" alt="ScreenShoot3"> <br />
### Conclusiones
Incluso con servidores virtuales si la granja tiene una buena infraestructura de red, puede dar un servicio muy aceptable en el momento que se introduce el concepto de balanceo de carga.