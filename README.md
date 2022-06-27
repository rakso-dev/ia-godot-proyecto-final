# Proyecto final Introduccion a la Inteligencia Artifical

Codigo fuente relacionado al proyecto final de la E.E. Introducción a la Inteligencia artifical, impartida por el Dr. Luis Felipe Marin Urias.

A traves de un videojuego realizado con el motor Godot se implementan los algoritmos:
* Busqueda Primero en Profundidad (DFS)
* Busqueda Primero en Anchura (BFS)
* Busqueda Avara (Greedy)

Se trata de un juego donde el usuario, a traves de entradas por medio de las teclas de direccion, intenta escapar de cuatro bots que intentan atacarle. 

Actualmente solo funciona el codigo de tres bots, aunque existe un bug relacionado con la posicion de los bots que hace que se cicle la posicion una vez dos o mas cruzan la primera vuelta. Es necesario corregir ese bug. En los archivos DFS-test.py, BFS-test.py y greedy-test.py se puede observar que dichos algoritmos funcionan al momento de retornar la ruta.