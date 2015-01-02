# Configuraciones Personales

Archivos de configuración personales, para clonar en $HOME y hacer link
simbolicos a las configuraciones necesarias

## Instalacion basica
Paquetes basicos para Debian
- sudo
``` console
# visudo
```
- git
``` console
$ git config --global user.name "Nombre"
$ git config --global user.email correo@servidor.dom
$ git config --global color.ui true
```
- vim
``` console
$ export VISUAL=vim
$ export EDITOR=vim
```
- screen

## Instalacion de servidor X
Para configurar interfaz grafica, es necesario instalar los siguientes paquetes
(en Debian)
- xorg
- openbox
- rxvt-unicode-256color
- lxappearance (escoger tema GTK2)
- nitrogen (cambiar fondo de escritorio)
