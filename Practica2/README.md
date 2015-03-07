Practica 2
==========
*Configurando RSync y SSH sin contraseñas*

En este repositorio guardaremos todas las practicas de la asignatura SWAP

### Objetivos
En Esta practica se pretende configurar dos servidores web para que tengan la misma configuración en su servidor apache, y también en las paginas que sirven a sus clientes

### Comandos usados
* Primero nos validamos como superusuario <br />
[usuario@WEB1 /]$ su<br />
Contraseña: <br />
[root@WEB1 /]# <br />

* Para generar las claves necesarias RSA <br />
[root@WEB1 /]# ssh-keygen -b 2048 -t rsa <br />
Generating public/private rsa key pair. <br />
Enter file in which to save the key (/root/.ssh/id_rsa):<br />
Enter passphrase (empty for no passphrase): <br />
Enter same passphrase again: <br />
Your identification has been saved in /root/.ssh/id_rsa. <br />
Your public key has been saved in /root/.ssh/id_rsa.pub. <br />
The key fingerprint is: <br />
c4:40:28:f5:92:04:f4:06:27:d5:d3:e2:f4:48:6d:f5 root@WEB1 <br />
The key's randomart image is: <br />
+--[ RSA 2048]----+ <br />
\|_.=+=+o__________\| <br />
\|__.*.o.o__.______\| <br />
\|___\.=..oo._._____\| <br />
\|___\.\_.=.+___E____\| <br />
\|_____+\_\=S_______\| <br />
\|______o_.________\| <br />
\|_________________\| <br />
\|_________________\| <br />
\|_________________\| <br />
+-----------------+ <br />


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