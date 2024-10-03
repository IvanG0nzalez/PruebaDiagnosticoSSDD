# Back-end para lugares

## Antes de ejecutar la aplicación

Para poder ejecutar la aplicación primero es necesario poseer **MySQL** instalado en nuestro dispositivo o en su defecto una instancia de MySQL en **Docker**. Se debe crear la base de datos con el nombre: db_lugares

Es necesario modificar el **usuario**, **contraseña** y **puerto** (en caso de ser necesario) en el archivo `config.json` ubicado dentro de:
/app/config
Este archivo contiene las credenciales de conexión a la base de datos.

## Instalar las dependencias y ejecutar la aplicación

Una vez creada la base de datos y modificadas las credenciales de acceso, se puede instalar las dependencias del proyecto. Para hacerlo:
   1. Ubicarse en el directorio `/lugares_backend`.
   2. Ejecutar el comando: npm install --save
   3. Después de que las dependencias se instalen se puede ejecutar el  comando: npm run start para ejecutar el servidor.
