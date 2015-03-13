Practica 3 <img src="nginx.jpg" alt="Logotipo" width="50px" height="50px">
==========
*Configurando Nginx y HaProxy como balanceadores de carga*

### Objetivos
En esta practica se pretende simular un granja web con un balanceador de carga y dos servidores finales, que aunque sean dos maquinas iguales, configuraremos la primera como si tuviera el doble de capacidad que la segunda.

### Pasos realizados
> * Paso 1 <br />
> Lo primero que realice fue la configuración de una de las maquinas servidoras de paginas web, con todos los parámetros relevantes en un servidor apache. <br />
> * Paso 2 <br />
> El siguiente paso fue instalar PHP, y preparar el servidor para que se pudiera utilizar phpMyAdmin para gestionar las bases de datos. De momento configure una base de datos local para poder realizar la configuración del servidor. <br />
> * Paso 3 <br />
> Después clone la maquina resultado para poder tener las dos maquinas que me servirían las paginas web de mi granja, por supuesto tuve que realizar algunos cambios en la configuración de la segunda maquina para que no hubiera conflictos de IP ni de resolución de nombres. <br />
> * Paso 4 <br />
> Una vez que ya tenia las maquinas listas prepare una tercera maquina que sería la que nos serviría de balanceador de carga, en esta maquina instalé nginx y haproxy, con sus ficheros de configuración. <br />

### Ficheros de Configuración finales

* **nginx.conf**
<pre><code>
events { <br />
    worker_connections  1024; <br />
}<br />
<br />
http {<br />
     upstream apaches {<br />
          ip_hash;<br />
          server 192.168.50.156 max_fails=3 fail_timeout=5s;<br />
          server 192.168.50.157;<br />
          keepalive 3;<br />
     }<br />
     server{<br /><br />
         listen 80;<br />
         server_name m3lb;<br />
         access_log /var/log/nginx/m3lb.access.log;<br />
         error_log /var/log/nginx/m3lb.error.log;<br />
         root /var/www/;<br />
         location /<br />
         {<br />
             proxy_pass http://apaches;<br />
             proxy_set_header Host $host;<br />
             proxy_set_header X-Real-IP $remote_addr;<br />
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;<br />
             proxy_http_version 1.1;<br />
             proxy_set_header Connection "";<br />
         }<br />
     }<br />
}<br />
</code></pre>

* **httpd.conf**
<pre><code>
ServerRoot "/etc/httpd"<br />
Listen *:80<br />
Include conf.modules.d/*.conf<br />
User apache<br />
Group apache<br />
ServerAdmin root@localhost<br />
`<Directory />`<br />
    AllowOverride none<br />
    \#Require all denied<br />
    Require all granted<br />
`</Directory><br />`
DocumentRoot "/var/www/html"<br />
`<Directory "/var/www"><br />`
    AllowOverride None<br />
    # Allow open access:<br />
    Require all granted<br />
`</Directory><br />`
`<Directory "/var/www/html"><br />`
    Options Indexes FollowSymLinks<br />
    AllowOverride None<br />
    Require all granted<br />
`</Directory><br />`
`<IfModule dir_module><br />`
    DirectoryIndex index.html<br />
`</IfModule><br />`
`<Files ".ht*"><br />`
    Require all denied<br />
`</Files><br />`
ErrorLog "logs/error_log"<br />
LogLevel warn<br />
`<IfModule log_config_module><br />`
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined<br />
    LogFormat "%h %l %u %t \"%r\" %>s %b" common<br />
    <IfModule logio_module><br />
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio<br />
    `</IfModule>`<br />
    CustomLog "logs/access_log" combined<br />
`</IfModule><br />`
`<IfModule alias_module><br />`
    ScriptAlias /cgi-bin/ /var/www/cgi-bin/<br />
`</IfModule><br />`
`<Directory "/var/www/cgi-bin"><br />`
    AllowOverride None<br />
    Options None<br />
    Require all granted<br />
`</Directory><br />`
`<IfModule mime_module><br />`
    TypesConfig /etc/mime.types<br />
    AddType application/x-compress .Z<br />
    AddType application/x-gzip .gz .tgz<br />
    AddType text/html .shtml<br />
    AddOutputFilter INCLUDES .shtml<br />
`</IfModule><br />`
AddDefaultCharset UTF-8<br />
EnableSendfile on<br />
IncludeOptional conf.d/*.conf<br />
ServerTokens Minor<br />
</code></pre>

### Conclusiones
En esta practica he aprendido como de manera fácil y barata podemos montar nuestra granja web y asegurarme de que el el *uptime* de mi sitio web sea *casi del 100%* gracias a los dos servidores de paginas web.