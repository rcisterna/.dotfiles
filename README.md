# Configuraciones Personales
Archivos de configuración personales, para clonar en $HOME y hacer link
simbolicos a las configuraciones necesarias

## Instalacion basica
Paquetes basicos para Debian
#### sudo
``` console
# visudo
```
## Instalacion de servidor X
Para configurar interfaz grafica, es necesario instalar los siguientes paquetes
(en Debian)
#### xorg
En el archivo ```/usr/share/X11/xorg.conf.d/40-prltools.conf``` buscar y editar las siguientes lineas,
agregando el modo "1280x800".
``` console
Section "Screen"
	Identifier	"Parallels Screen"
	Device	"Parallels Video"
	Monitor	"Parallels Monitor"
	Option	"NoMTRR"
	SubSection	"Display"
		Depth	24
		Modes	"1280x800" "1024x768" "800x600" "640x480"
	EndSubSection
EndSection
```
#### openbox
#### rxvt-unicode-256color
#### lxappearance (escoger tema GTK2)
#### nitrogen (cambiar fondo de escritorio)
