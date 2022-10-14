# MovieList

1. ¿En qué consiste el principio de responsabilidad única? ¿Cuál es su propósito?

El principio de responsabilidad única forma parte de los 5 principios Solid. Estos principios resuelven los problemas de una mala arquitectura.
Este principio se trata de mantener las clases lo mas simple posible, dividiendo las responsabilidades en clases mas pequeñas, de manera de que cada clase tenga una sola responsabilidad. De esta forma tenemos un código mas limpio, clases menos extensas y faciles de leer y escalar.

2. ¿Qué características tiene, según su opinión, un “buen” código o código limpio?

Debe ser fácilmente escalable, auto explicativo, que una persona que no lo haya hecho lo lea y lo entienda, ya sea porque se usaron nombres de variables, metodos u objetos que reflejen bien su función o porque hay comentarios en los casos donde requieren una explicación extra. 
No debe haber codigo repetido, se deben respetar los principios Solid, las clases tienen que ser simples y poco extensas

3. Detalla cómo harías todo aquello que no hayas llegado a completar.

Reproducir el trailer de la pelicula. 

Esta funcionalidad no la hice porque no encontré ni un solo registro de la API que contenga una URL a un video. Si estuviera presente, suponiendo que es un video de YouTube, usaría la API de YouTube y haria un embed del player del video en una WebView. Una tarea bastante simple

Apartado Recomendados para ti.

Creando una nueva seccion en la tabla, hubiese usado probablemente la misma celda (MoviesTableViewCell) modificando algunos constraints y propiedades para que la celda muestre todo el contenido sin scroll en modo vertical.
Para el contenido y los filtros, lo ideal es hacer una nueva consulta a la API con un limite de 6 peliculas y el filtro requerido, pero no vi que tenga esta opcion. En todo caso si no se podia de esa manera hubiese hecho el filtro manual localmente, cosa que no me parece una buena practica, lo ideal es que esta tarea la haga el backend, pero recorriendo el array de [Movie] se puede filtrar por lo que uno quiera facilmente.

Pruebas Unitarias

No me parecieron necesarias en este caso, dado el poco tiempo que tenia para dedicarle a este proyecto, preferí focalizarme en hacer una buena arquitectura.
