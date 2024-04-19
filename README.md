# Prueba
## Descripción del Proyecto:
El proyecto es una aplicación simple de autenticación que consta de dos pantallas: una pantalla de inicio de sesión y una pantalla de inicio. Los usuarios podrán iniciar sesión utilizando su número de teléfono, recibir un código de verificación por SMS y luego ingresar a la pantalla de inicio, donde verán la opción de cerrar sesión.

##  Estructura del Proyecto:
Pantalla de Inicio de Sesión (LoginPage):

Los usuarios pueden ingresar su número de teléfono. Se envía un código de verificación por SMS al número proporcionado. Después de recibir el código, los usuarios son dirigidos a la pantalla de verificación. Pantalla de Verificación de Código (OtpPage):

Los usuarios pueden ingresar el código de verificación recibido por SMS. Una vez verificado el código, los usuarios son dirigidos a la pantalla de inicio. Pantalla de Inicio (HomePage):

Proporciona un botón para cerrar sesión.

## Tecnologías Utilizadas:
Flutter: Para el desarrollo de la aplicación móvil. Firebase Authentication: Para autenticar a los usuarios a través de su número de teléfono y verificar el código de verificación. Firebase Firestore. 

## Ejecución del Proyecto: 

Para ejecutar el proyecto, sigue estos pasos:

Configuración del Entorno de Desarrollo:
Asegúrate de tener instalado Flutter en tu sistema. Puedes seguir la documentación oficial de Flutter para obtener instrucciones detalladas sobre cómo hacerlo. Creación del Proyecto:

Crea un nuevo proyecto Flutter utilizando el comando flutter create my_project. Configuración de Firebase:

Crea un nuevo proyecto en Firebase Console. Habilita la autenticación con número de teléfono en la sección "Authentication". Configura tu proyecto de Flutter para usar Firebase siguiendo las instrucciones detalladas en la documentación oficial de Firebase para Flutter. Desarrollo del Código:

Implementa las pantallas de inicio de sesión, verificación y inicio, junto con la lógica de autenticación utilizando Firebase Authentication y Firestore. Ejecución del Proyecto:

Abre una terminal en el directorio de tu proyecto Flutter. 
## Ejecuta el comando:
flutter run,
o
flutter run -d web
para compilar y ejecutar la aplicación en un emulador o dispositivo conectado. 

## Prueba de la Aplicación:

Prueba todas las funcionalidades de la aplicación, incluyendo el inicio de sesión, la verificación del código y la visualización en la pantalla de inicio.
