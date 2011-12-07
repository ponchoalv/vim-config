Acerca
=====

Esta configuración de vim está pensada para trabajar principalmente con php, Javascript y python. Para desarrollo web tambíen sirve tiene compatibilidad para less, stylus, css3, colores para css3, coffeescript y nodejs.

Instalación
============

Clone the repository:

		$ git clone git://github.com/ponchoalv/vim-config.git ~/.vim
		$ git submodule init
		$ git submodule update

Create a symbolic link of the .vimrc file into your home directory:

		$ ln -s ~/.vim/.vimrc ~/.vimrc

El plugin commandt lo tienen que compilar, incluye las instrucciones, se activa con las teclas:

		$ ,t

El plugin vimango (para navegación entre archivos de un proyecto django) necesita que copies vimango.py al path de python.

La fuente que uso es Meslo, deje el repositorio como submodule, entrar ahí para bajarsela.
Suerte! :D
