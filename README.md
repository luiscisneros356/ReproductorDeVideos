# Descripción:
 
 Esta app permite visualizar videos obtenidos de Youtube, subir sus propios videos y votar los mismos para establecer un rating. 
 Además, permite conocer en función de los videos votados y la puntuación ingresada otros videos recomendados en relación a la temática de 
 interés para ese usuario.
 
 Existen 2 tipo de usarios: el que es considerado como tal, es decir, que tiene un username y password (estos se encuentran en el path assets/user.json). Por el otro lado el que no tiene estas credenciales e ingresa como invitado.
 El primero puede acceder a la plataforma, ver el contenido de la misma, votar  y subir videos, además de conocer los recomendados.
 La diferencia con el segundo caso es que este no prodrá subir videos.

Tanto el inicio de sesión como los videos subidos a la plataforma y los votados tienen persistencia local.

# Packages:
Provider para manejador de estado

Hive y Path Provider para persistencia de datos

Youtube Player para reproducir los videos



# Instalación:

clone repository

flutter pub get

flutter pub run build_runner build --delete-conflicting-outputs

flutter run 




# Imágenes

![alt text](https://github.com/luiscisneros356/ReproductorDeVideos/blob/main/imagenes_git/home.png)
![alt text](https://github.com/luiscisneros356/ReproductorDeVideos/blob/main/imagenes_git/recomended_video.png)
![alt text](https://github.com/luiscisneros356/ReproductorDeVideos/blob/main/imagenes_git/update_video.png)
![alt text]( https://github.com/luiscisneros356/ReproductorDeVideos/blob/main/imagenes_git/login.png)
