# Flutter - Reservación de canchas de tenis con SQFLITE

Proyecto de flutter para la reservación de canchas de tenis con base de datos local.

Esta aplicación permite realizar reservaciones en tres tipos de canchas, almacenando las reservas en una Base de datos local utilizando SQFLITE.
Para hacer la reservación se selecciona la cancha y al momento de entrar a la pantalla de reserva se solicita permiso para acceder a la localización del dispositivo, esto para conocer la probabilidad de lluvia de la zona utilizando el API de WEATHERBIT en la fecha a escoger (En caso de no permitir el acceso a la localización se tomará por defecto la latitud y longitud de Caracas, Venezuela), luego de seleccionar la fecha sólo se debe proporcionar el nombre de la persona que solicita la reservación para poder finalizar la creación.

Al momento de escoger una fecha solo se puede escoger desde el dia actual hasta los siguientes 16 días siguientes ya que esos son los dias permitidos por el API

<div>
    <img src="https://img.shields.io/badge/Made%20with-flutter-blue">
    <img src="https://img.shields.io/badge/SDK%20version-%3E%3D2.18-orange">
</div>

## Requerimientos

Para obtener la probabilidad de lluvia es necesario incluir el token de WEATHERBIT. <a href="https://www.weatherbit.io/api/weather-forecast-16-day" target="_blank">CONSIGUELO AQUÍ.</a>

Luego debe escribir su token en la línea 'YOUR-TOKEN'. Ubicado en el archivo lib/providers/form_provider.dart.

## Packages

<ul>
    <li>
        <a href="https://pub.dev/packages/animate_do" target="_blank">Animate do</a>
    </li>
    <li>
        <a href="https://pub.dev/packages/http" target="_blank">http</a>
    </li>
    <li>
        <a href="https://pub.dev/packages/location" target="_blank">Location</a>
    </li>
    <li>
        <a href="https://pub.dev/packages/provider" target="_blank">Provider</a>
    </li>
    <li>
        <a href="https://pub.dev/packages/sqflite" target="_blank">sqflite</a>
    </li>
</ul>
