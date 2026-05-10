<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingreso Administrativo | Mel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --zen-bg: #faf9f6;
            --zen-sage: #94a684;
            --zen-clay: #d4c1ac;
            --text-main: #3c403d;
        }

        body {
            font-family: 'Outfit', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: var(--zen-bg);
            /* Sutil textura de papel para mantener la armonía */
            background-image: radial-gradient(var(--zen-clay) 0.5px, transparent 0.5px);
            background-size: 30px 30px;
            color: var(--text-main);
        }

        .login-card {
            background: white;
            padding: 4rem 3rem;
            border-radius: 32px;
            box-shadow: 0 20px 50px rgba(148, 166, 132, 0.05);
            width: 100%;
            max-width: 380px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.8);
        }

        .login-card h2 {
            font-size: 2rem;
            font-weight: 500;
            color: var(--zen-sage);
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .login-card p {
            font-weight: 300;
            color: #999;
            margin-bottom: 2.5rem;
            font-size: 0.95rem;
        }

        .input-group {
            margin-bottom: 1.2rem;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--zen-clay);
            margin-bottom: 8px;
            margin-left: 5px;
            font-weight: 600;
        }

        .input-group input {
            width: 100%;
            padding: 1.1rem;
            border-radius: 16px;
            border: 1px solid #f0f0f0;
            background: #fdfdfd;
            font-family: 'Outfit', sans-serif;
            font-size: 1rem;
            outline: none;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            border-color: var(--zen-sage);
            background: white;
            box-shadow: 0 5px 15px rgba(148, 166, 132, 0.05);
        }

        .btn-login {
            width: 100%;
            padding: 1.1rem;
            border: none;
            border-radius: 16px;
            background: var(--zen-sage);
            color: white;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(148, 166, 132, 0.2);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(148, 166, 132, 0.3);
        }

        .error-msg {
            background: #fff5f5;
            color: #d4a3a3;
            padding: 10px;
            border-radius: 12px;
            font-size: 0.85rem;
            margin-bottom: 1.5rem;
            border: 1px solid #fceaea;
        }

        .back-link {
            display: inline-block;
            margin-top: 2rem;
            color: #ccc;
            text-decoration: none;
            font-size: 0.85rem;
            transition: 0.3s;
        }

        .back-link:hover {
            color: var(--zen-sage);
        }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Bienvenida, Mel</h2>
        <p>Gestiona tu tiempo con calma.</p>

        <% if(request.getParameter("error") != null) { %>
            <div class="error-msg">
                Credenciales incorrectas. Inténtalo de nuevo.
            </div>
        <% } %>

        <form action="Controlador" method="POST">
            <div class="input-group">
                <label>Usuario</label>
                <input type="text" name="txtUser" placeholder="Tu usuario" required>
            </div>
            
            <div class="input-group">
                <label>Contraseña</label>
                <input type="password" name="txtPass" placeholder="••••••••" required>
            </div>

            <button type="submit" name="accion" value="Validar" class="btn-login">
                Entrar al Panel
            </button>
        </form>

        <a href="index.jsp" class="back-link">← Volver a la agenda pública</a>
    </div>

</body>
</html>