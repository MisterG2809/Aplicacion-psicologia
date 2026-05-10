package controlador;

import config.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        con = cn.getConnection();

        if (con == null) {
            response.getWriter().println("Error de conexion a la DB");
            return;
        }

        try {
            if (accion.equalsIgnoreCase("Validar")) {
                String user = request.getParameter("txtUser");
                String pass = request.getParameter("txtPass");
                ps = con.prepareStatement("SELECT * FROM usuarios WHERE user=? AND pass=?");
                ps.setString(1, user);
                ps.setString(2, pass);
                rs = ps.executeQuery();
                if (rs.next()) {
                    request.getSession().setAttribute("admin", user);
                    response.sendRedirect("admin.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=1");
                }
            } else if (accion.equalsIgnoreCase("RegistrarCita")) {
                int idHorario = Integer.parseInt(request.getParameter("txtIdHorario"));
                String nombre = request.getParameter("txtNombre");
                String telefono = request.getParameter("txtTelefono");

                ps = con.prepareStatement("INSERT INTO citas (id_horario, nombre_paciente, telefono) VALUES (?, ?, ?)");
                ps.setInt(1, idHorario);
                ps.setString(2, nombre);
                ps.setString(3, telefono);
                ps.executeUpdate();

                ps = con.prepareStatement("UPDATE horarios_disponibles SET estado='reservado' WHERE id_horario=?");
                ps.setInt(1, idHorario);
                ps.executeUpdate();

                response.sendRedirect("index.jsp");
            } else if (accion.equalsIgnoreCase("GuardarFecha")) {
                String fecha = request.getParameter("txtFecha");
                String hora = request.getParameter("txtHora");
                ps = con.prepareStatement("INSERT INTO horarios_disponibles(fecha, hora, estado) VALUES(?,?, 'disponible')");
                ps.setString(1, fecha);
                ps.setString(2, hora);
                ps.executeUpdate();
                response.sendRedirect("admin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion != null && accion.equalsIgnoreCase("Eliminar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                con = cn.getConnection();
                ps = con.prepareStatement("DELETE FROM citas WHERE id_horario=?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps = con.prepareStatement("DELETE FROM horarios_disponibles WHERE id_horario=?");
                ps.setInt(1, id);
                ps.executeUpdate();
                response.sendRedirect("admin.jsp");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
