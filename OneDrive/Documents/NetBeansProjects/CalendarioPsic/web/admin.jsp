<%@page import="java.sql.*"%>
<%@page import="config.Conexion"%>
<%
    if (session.getAttribute("admin") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Administrativo | Mel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --zen-bg: #faf9f6; --zen-sage: #94a684; --text: #3c403d; }
        body { font-family: 'Outfit', sans-serif; margin: 0; background: var(--zen-bg); display: flex; min-height: 100vh; }
        
        .sidebar {
            width: 260px; background: white; border-right: 1px solid #f0f0f0; padding: 3rem 2rem;
            display: flex; flex-direction: column; position: fixed; height: 100vh;
        }
        .sidebar h2 { color: var(--zen-sage); font-weight: 600; margin-bottom: 3rem; }
        .nav-link { padding: 1rem; text-decoration: none; color: #999; border-radius: 12px; margin-bottom: 0.5rem; transition: 0.3s; }
        .nav-link.active { color: var(--zen-sage); background: #f1f5f0; font-weight: 600; }
        
        .main-content { margin-left: 310px; padding: 4rem; width: 100%; }
        .glass-card { background: white; border: 1px solid #f0f0f0; border-radius: 24px; padding: 2.5rem; margin-bottom: 3rem; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr auto; gap: 1.5rem; align-items: end; }
        .input-group input { width: 100%; padding: 1rem; border-radius: 12px; border: 1px solid #eee; outline: none; }
        .btn-add { background: var(--zen-sage); color: white; border: none; padding: 1rem 2rem; border-radius: 12px; font-weight: 600; cursor: pointer; }

        table { width: 100%; border-collapse: separate; border-spacing: 0 10px; }
        tr.data-row { background: white; }
        tr.data-row td { padding: 1.5rem; }
        tr.data-row td:first-child { border-radius: 16px 0 0 16px; }
        tr.data-row td:last-child { border-radius: 0 16px 16px 0; }
        .status-pill { padding: 6px 14px; border-radius: 50px; font-size: 0.7rem; font-weight: 600; text-transform: uppercase; }
        .disponible { background: #f1f5f0; color: var(--zen-sage); }
        .reservado { background: #faf5f5; color: #d4a3a3; }
        .btn-delete { color: #d4a3a3; text-decoration: none; font-size: 0.8rem; font-weight: 600; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Mel Admin</h2>
        <nav style="display: flex; flex-direction: column; flex-grow: 1;">
            <a href="admin.jsp" class="nav-link active">Horarios</a>
            <a href="#" class="nav-link">Citas</a>
        </nav>
        <a href="login.jsp" class="nav-link" style="color: #d4a3a3; margin-top: auto;">Salir</a>
    </div>

    <div class="main-content">
        <header style="margin-bottom: 3rem;">
            <h1 style="font-weight: 600;">Gestión de Agenda</h1>
            <p style="color: #bbb;">Organiza los espacios de consulta.</p>
        </header>
        <div class="glass-card">
            <form action="Controlador" method="POST" class="form-grid">
                <div class="input-group"><input type="date" name="txtFecha" required></div>
                <div class="input-group"><input type="time" name="txtHora" required></div>
                <button type="submit" name="accion" value="GuardarFecha" class="btn-add">Publicar</button>
            </form>
        </div>
        <table>
            <tbody>
                <%
                    try {
                        Conexion cn = new Conexion();
                        Connection con = cn.getConnection();
                        if (con != null) {
                            String sql = "SELECT * FROM horarios_disponibles ORDER BY fecha DESC, hora DESC";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                %>
                <tr class="data-row">
                    <td style="font-weight: 500;"><%= rs.getString("fecha") %></td>
                    <td><%= rs.getString("hora") %></td>
                    <td><span class="status-pill <%= rs.getString("estado").toLowerCase() %>"><%= rs.getString("estado") %></span></td>
                    <td><a href="Controlador?accion=Eliminar&id=<%= rs.getInt("id_horario") %>" class="btn-delete" onclick="return confirm('¿Borrar?')">Borrar</a></td>
                </tr>
                <% } con.close(); } } catch (Exception e) { } %>
            </tbody>
        </table>
    </div>
</body>
</html>