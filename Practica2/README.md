Practica 2
==========
*Configurando RSync y SSH sin contraseñas*

En este repositorio guardaremos todas las practicas de la asignatura SWAP

### Objetivos
En Esta practica se pretende configurar dos servidores web para que tengan la misma configuración en su servidor apache, y también en las paginas que sirven a sus clientes

### Comandos usados
* Primero nos validamos como superusuario
[usuario@WEB1 /]$ su
Contraseña: 
[root@WEB1 /]#

* Para generar las claves necesarias RSA
[root@WEB1 /]# ssh-keygen -b 2048 -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
c4:40:28:f5:92:04:f4:06:27:d5:de:e2:f4:48:6d:f5 root@WEB1
The key's randomart image is:
+--[ RSA 2048]----+
| .=+=+o          |
|  .*.o.o  .      |
|   .=..oo. .     |
|   . .=.+   E    |
|     + =S        |
|      o .        |
|                 |
|                 |
|                 |
+-----------------+


* Copiamos la clave publica al segundo servidor
[root@WEB1 /]# ssh-copy-id root@<WEB2> *ponemos su numbre DNS*
root@WEB2's password 
Number of key(s) added: 1

* Probamos que rsync puede copiar los ficheros sin que tengamos que introducir ninguna contraseña
[root@WEB1 /]# rsync -avz -e ssh root@<WEB2>:/var/www/html/ /var/www/html/
receiving incremental file list
sent 262 bytes  received 55856 bytes  112236.00 bytes/sec
total size is 33977792  speedup is 605.47

<!--
![Imagen de Prueba](/resources/prueba.jpg = 100x50)
-->