# Mel Psicología - Sistema de Agenda de Citas

Aplicación web para gestionar la agenda de citas psicológicas. Los pacientes pueden ver los horarios disponibles y reservar una cita. La administradora (Mel) puede publicar, revisar y eliminar horarios desde un panel privado.

## Tecnologías

- **Backend:** Java 11, Jakarta Servlets
- **Frontend:** JSP, CSS (Glassmorphism)
- **Servidor:** GlassFish 6
- **Base de datos:** MySQL (XAMPP)

## Estructura

```
src/java/
  config/Conexion.java        -- Conexión a MySQL
  controlador/Controlador.java -- Servlet principal
web/
  index.jsp                    -- Página pública de reservas
  admin.jsp                    -- Panel de administración
  login.jsp                    -- Login para administradora
```

## Base de datos

```sql
CREATE DATABASE psicologia_db;
```

**Tablas:**
- `usuarios` — credenciales del admin (user: `mel`, pass: `12345`)
- `horarios_disponibles` — fechas y horas publicadas
- `citas` — reservas de pacientes

## Requisitos

1. XAMPP con MySQL corriendo
2. GlassFish 6+
3. `mysql-connector-java-5.1.23-bin.jar` en `web/WEB-INF/lib/`
4. NetBeans (recomendado)

## Ejecutar

1. Inicia MySQL desde XAMPP
2. Crea la BD y las tablas con el script SQL
3. Abre el proyecto en NetBeans
4. Da clic en **Run** (el proyecto se despliega en GlassFish)
