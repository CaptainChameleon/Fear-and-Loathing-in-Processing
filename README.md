# Fear-and-Loathing-in-Processing
### Creando Interfaces de Usuario - Práctica 6


## Introducción
Se pide proponer un prototipo que combine de salida gráfica e interacción en respuesta a una captura de vídeo. Para ello se propone un pequeño juego al estilo endless runner, como podría ser el juego del T-Rex ofrecido por el navegador Chrome cuando el usuario no tiene conexión a internet, solo que con una estética más synthwave.

La principal inspiración de la que bebe es el juego Audiosurf, el cual permite generar niveles a partir de cualquier canción.

![Teaser](teaser0.gif)

## Controles y detección de caras
Para el control del vehículo se emplea las teclas A y D del teclado, junto al detector de caras de Cam Viola, dado que no se necesita una alta precisión, es más, la baja precisión es un componente interesante del gameplay. 

Dividimos la imagen captada por la cámara en 3 partes, siendo la parte del centro neutra. Cuando el usuario sitúa su cara en los extremos se activan las flags de movimiento hacia la izquierda o la derecha, las cuales provocan el desplazamiento del vehículo cuando este se actualiza.

## Escena
Para el escenario se ha empleado el ruido de Perlin para crear un terreno semejante a un desierto con pequeñas dunas. Desplazando los valores del ruido de fila en fila se consigue un efecto ilusorio de movimiento, como si el modelo de coche utilizado se desplazase por el desierto. Según la cantidad de filas que se desplacen en cada iteración, podemos variar la velocidad de dicho movimiento.

## Colisiones
La principal dificultad del juego consiste en esquivar obstáculos que aparecen en la carretera. Siempre ofrecerán un hueco por el que poder escabullirse. La detección de colisión se realiza por medio de hitboxes, las cuales acompañan a cada modelo en todo momento. Las hitboxes se calculan obteniendo los vértices más extremos para cada eje. Si una jugadora colisiona con un obstáculo, este se torna rojo.

## Análisis de ficheros de audio
Un aspecto interesante del gameplay es que todo el movimiento, tanto del escenario como de los obstáculos, está vinculado a la detección de beats en un fichero de audio. Para ello se emplea la librería Minim. Cada 4 beats se generan nuevos obstáculos y se produce un pulso en la velocidad de movimiento general, la cual disminuye paultinamente hasta que se detecta un nuevo conjunto de beats.
