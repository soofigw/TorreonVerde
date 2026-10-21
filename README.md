# TorreonVerde

**TorreonVerde** es una aplicación para iOS desarrollada con **Swift y SwiftUI** que permite registrar, consultar y dar seguimiento a reportes sobre problemas ambientales en **Torreón, Coahuila, México**.

El proyecto busca promover la participación ciudadana y la conciencia ambiental mediante una herramienta sencilla para documentar situaciones que afectan al entorno, como acumulación de basura, fugas de agua, daños en áreas verdes o contaminación.

> **Estado del proyecto:** versión académica en desarrollo. Las funciones principales de registro, consulta, filtrado y seguimiento ya están implementadas. Los reportes se almacenan localmente en el dispositivo; la aplicación no los envía automáticamente a autoridades ni cuenta actualmente con un servicio público de atención.

## Objetivo

Facilitar que las personas identifiquen y documenten problemas ambientales de su comunidad, incorporando una descripción, ubicación y evidencia fotográfica, y puedan consultar su estado de seguimiento.

## Funcionalidades implementadas

### Inicio

- Pantalla principal con identidad visual en tonos verdes, amarillos y crema.
- Acceso rápido para crear un reporte ambiental.
- Resumen con **tres indicadores**:
  - **Total:** número de reportes registrados.
  - **En proceso:** reportes que se encuentran en atención.
  - **Resueltos:** reportes marcados como solucionados.
- Vista de los tres reportes más recientes, con acceso a sus detalles.
- Acceso a la lista completa de reportes.

> Los reportes **Pendientes** también se registran y se pueden consultar o filtrar; simplemente no tienen un contador independiente en Inicio.

### Registro de reportes

Cada reporte contiene los siguientes campos obligatorios:

| Campo | Descripción |
| --- | --- |
| Título | Nombre breve del problema ambiental. |
| Categoría | Tipo de problema reportado. |
| Descripción | Explicación de la situación observada. |
| Ubicación | Colonia, calle o referencia del lugar. |
| Fotografía | Imagen seleccionada de la galería como evidencia. |

El formulario valida que los campos de texto no estén vacíos o compuestos únicamente por espacios, requiere una categoría y una fotografía válida, muestra una vista previa de la imagen y presenta mensajes de confirmación o error al guardar.

### Categorías disponibles

- Basura y residuos.
- Fugas de agua.
- Áreas verdes.
- Contaminación del aire.
- Quema de residuos.
- Otros problemas.

### Consulta y búsqueda

- Lista de reportes registrados.
- Búsqueda por título o ubicación.
- Filtros por categoría y estado.
- Tarjetas con información resumida y acceso al detalle.

### Seguimiento de reportes

Los reportes pueden tener tres estados:

| Estado | Significado |
| --- | --- |
| **Pendiente** | El problema fue registrado y aún no se ha atendido. |
| **En proceso** | El reporte está siendo atendido o revisado. |
| **Resuelto** | El problema se considera solucionado. |

Desde la pantalla de detalle es posible consultar la información del reporte, cambiar su estado y eliminarlo mediante una confirmación previa. Los cambios se reflejan en las estadísticas de Inicio.

### Almacenamiento local

La aplicación utiliza **SwiftData** para guardar los reportes y sus datos en el dispositivo. Las fotografías se almacenan junto con la información de cada reporte mediante un atributo de datos binarios con almacenamiento externo cuando corresponde.

**Importante:** el almacenamiento es local. Los datos no se sincronizan entre dispositivos ni se publican en un servidor.

## Tecnologías utilizadas

| Tecnología | Uso |
| --- | --- |
| **Swift** | Lenguaje de programación. |
| **SwiftUI** | Construcción de la interfaz de usuario. |
| **SwiftData** | Persistencia local de reportes. |
| **PhotosUI** | Selección de fotografías desde la galería. |
| **Xcode** | Desarrollo, compilación y pruebas en simulador. |
| **Git y GitHub** | Control de versiones y repositorio del proyecto. |

**Compatibilidad:** iOS 17 o posterior, debido al uso de SwiftData.

## Organización del proyecto

La aplicación está organizada en grupos para separar los datos, las pantallas y los componentes reutilizables:

```text
TorreonVerde/
├── TorreonVerdeApp.swift
├── ContentView.swift
├── Modelos/
│   ├── Reporte.swift
│   ├── CategoriaReporte.swift
│   └── EstadoReporte.swift
├── Vistas/
│   ├── VistaInicio.swift
│   ├── VistaNuevoReporte.swift
│   ├── VistaListaReportes.swift
│   └── VistaDetalleReporte.swift
├── Componentes/
│   ├── ColoresApp.swift
│   ├── TarjetaEstadistica.swift
│   └── TarjetaReporte.swift
```

> Esta representación muestra los archivos principales desarrollados hasta ahora.

## ¿Cómo funciona la aplicación?

1. **Abrir TorreonVerde.** La pantalla de Inicio muestra un resumen y los reportes recientes.
2. **Crear un reporte.** Entrar en la pestaña de registro y completar título, categoría, descripción y ubicación.
3. **Agregar evidencia.** Seleccionar una fotografía desde la galería y revisar su vista previa. Se recomienda evitar rostros, placas y otros datos personales.
4. **Guardar.** La aplicación valida la información y almacena el reporte localmente con estado inicial **Pendiente**.
5. **Consultar.** Abrir la lista de reportes y utilizar la búsqueda o los filtros.
6. **Dar seguimiento.** Entrar al detalle para cambiar el estado a **En proceso** o **Resuelto**.
7. **Revisar el resumen.** Volver a Inicio para ver los contadores actualizados.
8. **Eliminar, si es necesario.** Desde el detalle, confirmar la eliminación del reporte.

## Ejecutar el proyecto

### Requisitos

- Una Mac con Xcode instalado.
- Un simulador de iPhone compatible con **iOS 17 o posterior**, o un dispositivo iOS configurado para desarrollo.

### Instrucciones

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/soofigw/TorreonVerde.git
   ```

2. Abrir la carpeta del proyecto y cargar el archivo de proyecto de Xcode (`.xcodeproj`) desde Xcode.
3. Seleccionar un simulador de iPhone con iOS 17 o posterior.
4. Ejecutar con **Command + R** o mediante el botón **Run** de Xcode.
5. Utilizar las pestañas para crear, consultar y actualizar reportes.

> Para seleccionar una fotografía durante las pruebas en simulador, es necesario que la galería del simulador tenga imágenes disponibles.

## Diseño

La interfaz utiliza una paleta inspirada en la naturaleza:

- **Verde oscuro:** encabezados y textos destacados.
- **Verde natural:** acciones y elementos de identidad ambiental.
- **Amarillo:** botones principales y detalles visuales.
- **Crema:** superficies de apoyo y secciones informativas.

Se utilizan tarjetas, iconos de SF Symbols y navegación por pestañas para mantener una experiencia clara y sencilla.

## Pruebas y estado actual

- El indicador **En proceso** funciona correctamente y se actualiza al cambiar el estado de los reportes.

## Alcance y consideraciones

TorreonVerde es un proyecto académico orientado a la sensibilización y documentación de problemas ambientales en Torreón. **No es una plataforma oficial de denuncias ni garantiza la atención de reportes por parte de autoridades.**

Para proteger la privacidad de las personas, se recomienda fotografiar el problema ambiental sin incluir rostros, datos personales o información sensible.

## Desarrollo

Proyecto académico de desarrollo de aplicaciones iOS.

**Repositorio:** [github.com/soofigw/TorreonVerde](https://github.com/soofigw/TorreonVerde)

---

*Una ciudad más limpia comienza con observar, reportar y actuar.*
