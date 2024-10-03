# Aplicación móvil - Prueba de Diagnóstico

**Correo** -> `admin@admin.admin`
**Contraseña** -> `admin`

## Antes de utilizar

Para utilizar la aplicación primero es necesario **crear las ubicaciones** en el back-end de `/lugares_backend`. De lo contrario, **no se mostrará información** en el mapa y las solicitudes de búsqueda fallarán.

Al crear y ejecutar el back-end se debe **buscar la IP** del dispositivo en el que se está ejecutando el servidor. En **Windows** se utiliza el comando: ipconfig y se busca la IP en **Ethernet** o **Wi-Fi IPv4**, por ejemplo: 192.168.1.19

Con esa dirección IP se requiere modificar el archivo `Conexion.dart` ubicado en: `./prueba_diagnostico/lib/controllers` y reemplazar la dirección IP del archivo por la obtenida previamente, por ejemplo: http://192.168.1.19:3000/api/

## Descargar e instalar la aplicación

Para descargar e instalar la aplicación a un dispositivo móvil:
1. Conectar el dispositivo al computador.
2. Habilitar las **opciones de desarrollador** en el dispositivo para permitir:
   - **Depuración USB**
   - **Instalación por USB**
3. Luego, dentro del **IDE** o desde **CMD**, seleccionar el dispositivo móvil y ejecutar el siguiente comando, estando ene el directorio `/prueba_diagnostico`: flutter run. Y la aplicación empezará a instalarse y ejecutarse en el dispositivo.