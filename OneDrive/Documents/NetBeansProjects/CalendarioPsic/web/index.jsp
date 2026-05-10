<%@page import="java.sql.*"%>
<%@page import="config.Conexion"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Espacio de Calma | Mel Psicología</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --zen-bg: #faf9f6;
            --zen-sage: #94a684;
            --zen-earth: #a68966;
            --zen-clay: #d4c1ac;
            --text-main: #3c403d;
            --glass: rgba(255, 255, 255, 0.6);
        }

        body {
            font-family: 'Outfit', sans-serif;
            margin: 0;
            background-color: var(--zen-bg);
            color: var(--text-main);
            background-image: radial-gradient(var(--zen-clay) 0.5px, transparent 0.5px);
            background-size: 40px 40px;
        }

        .header {
            padding: 6rem 2rem 3rem;
            text-align: center;
        }

        .header h1 {
            font-size: 2.8rem;
            font-weight: 500;
            color: var(--zen-sage);
            margin: 0;
            letter-spacing: -0.5px;
        }

        .header p { font-weight: 300; opacity: 0.8; font-size: 1.1rem; margin-top: 10px; }

        .container {
            max-width: 1100px;
            margin: 0 auto 5rem;
            padding: 0 2rem;
        }

        .schedule-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2.5rem;
        }

        .time-card {
            background: var(--glass);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: 28px;
            padding: 3rem;
            text-align: center;
            transition: all 0.5s ease;
        }

        .time-card:hover {
            transform: translateY(-8px);
            background: white;
            box-shadow: 0 20px 40px rgba(148, 166, 132, 0.08);
        }

        .date { color: var(--zen-earth); font-weight: 500; font-size: 0.85rem; text-transform: uppercase; letter-spacing: 3px; display: block; }
        .hour { font-size: 2.2rem; font-weight: 400; margin: 0.8rem 0; color: var(--text-main); display: block; }

        .btn-reserve {
            margin-top: 1.5rem;
            width: 100%;
            padding: 1.1rem;
            border: 1px solid var(--zen-sage);
            background: transparent;
            color: var(--zen-sage);
            border-radius: 16px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-reserve:hover {
            background: var(--zen-sage);
            color: white;
        }

        /* Modal Zen */
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(60, 64, 61, 0.1); backdrop-filter: blur(10px); z-index: 1000;
            justify-content: center; align-items: center;
        }
        .modal-content {
            background: var(--zen-bg); padding: 3.5rem; border-radius: 32px; width: 90%; max-width: 400px;
            text-align: center; box-shadow: 0 30px 60px rgba(0,0,0,0.05);
        }
        .modal-content h3 { font-size: 1.8rem; font-weight: 500; color: var(--zen-sage); margin-top: 0; }
        .input-group { margin-bottom: 1.5rem; }
        .input-group input {
            width: 100%; padding: 1.2rem; border-radius: 16px; border: 1px solid var(--zen-clay);
            background: white; font-family: inherit; outline: none; box-sizing: border-box;
        }
        .btn-confirm { background: var(--zen-sage); color: white; border: none; width: 100%; padding: 1.2rem; border-radius: 16px; font-weight: 600; cursor: pointer; }
        .btn-cancel { background: none; border: none; color: #b2bec3; cursor: pointer; margin-top: 1rem; }
    </style>
</head>
<body>

    <header class="header">
        <h1>Mel Psicología</h1>
        <p>Un respiro para el alma, un espacio para crecer.</p>
    </header>

    <div class="container">
        <div class="schedule-grid">
            <%
                try {
                    Conexion cn = new Conexion();
                    Connection con = cn.getConnection();
                    if (con != null) {
                        String sql = "SELECT * FROM horarios_disponibles WHERE estado='disponible' ORDER BY fecha ASC, hora ASC";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("id_horario");
                            String fecha = rs.getString("fecha");
                            String hora = rs.getString("hora");
            %>
            <div class="time-card">
                <span class="date"><%= fecha %></span>
                <span class="hour"><%= hora %></span>
                <button class="btn-reserve" onclick="abrirModal('<%= id %>', 'el <%= fecha %> a las <%= hora %>')">Reservar sesión</button>
            </div>
            <%
                        }
                        con.close();
                    }
                } catch (Exception e) {
                    out.println("Cargando paz...");
                }
            %>
        </div>
    </div>

    <div id="modalReserva" class="modal-overlay">
        <div class="modal-content">
            <h3>Bienvenido</h3>
            <p>Agendaremos para <br><strong id="infoCita"></strong></p>
            <form action="Controlador" method="POST">
                <input type="hidden" name="txtIdHorario" id="idHorarioSeleccionado">
                <div class="input-group">
                    <input type="text" name="txtNombre" placeholder="Nombre completo" required>
                </div>
                <div class="input-group">
                    <input type="tel" name="txtTelefono" placeholder="Teléfono" required>
                </div>
                <button type="submit" name="accion" value="RegistrarCita" class="btn-confirm">CONFIRMAR</button>
                <button type="button" class="btn-cancel" onclick="cerrarModal()">Regresar</button>
            </form>
        </div>
    </div>

    <script>
        function abrirModal(id, info) {
            document.getElementById('idHorarioSeleccionado').value = id;
            document.getElementById('infoCita').innerText = info;
            document.getElementById('modalReserva').style.display = 'flex';
        }
        function cerrarModal() {
            document.getElementById('modalReserva').style.display = 'none';
        }
    </script>
</body>
</html>