package br.csi.dao;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;


public class ConectarBancoDados {

    public static Connection conectarBancoPostgress() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");
        System.out.println("Driver carregado");
        String url = "jdbc:postgresql://localhost:5432/sistema-adocao-simples";
        String user = "postgres";
        String senha = "4682";
        Connection conn =
                DriverManager.getConnection(url, user, senha);
        return conn;
    }
}
