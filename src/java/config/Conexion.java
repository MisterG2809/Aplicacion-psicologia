package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    Connection con;
    String url = "jdbc:mysql://localhost:3306/psicologia_db?useSSL=false&serverTimezone=UTC";
    String user = "root";
    String pass = "";

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
            System.out.println(">>> [OK] Conectado a la base de datos");
        } catch (Exception e) {
            System.err.println(">>> [ERROR] No se pudo conectar: " + e.getMessage());
        }
        return con;
    }
}