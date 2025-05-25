package br.csi.dao;

import br.csi.model.Cachorro;

import java.sql.*;
import java.util.ArrayList;

public class CachorroDAO {

    public Boolean inserirCachorro ( Cachorro cachorro) {

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress();
            PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO cachorro (nome, raca, sexo, porte, adotado) VALUES (?, ?, ?, ?, ?)"
            );
            stmt.setString(1, cachorro.getNome());
            stmt.setString(2, cachorro.getRaca());
            stmt.setString(3, cachorro.getSexo());
            stmt.setString(4, cachorro.getPorte());
            stmt.setBoolean ( 5,cachorro.isAdotado ());

            stmt.execute();

        }catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
            System.out.println("Erro ao inserir cachorro");
        }

        return true;

    }

    public boolean excluirCachorro (int id) {

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress();
            PreparedStatement stmt = conn.prepareStatement(
                    "DELETE FROM cachorro WHERE id = ?"
            );

            stmt.setInt(1, id);
            stmt.execute();


        }catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
            System.out.println("Erro ao excluir cachorro");
        }

        return true;

    }

    public boolean alterarCachorro(Cachorro cachorro) {
        String sql = "UPDATE cachorro "
                + "SET nome = ?, raca = ?, sexo = ?, porte = ?, adotado = ? "
                + "WHERE id = ?";

        try (
                Connection conn = ConectarBancoDados.conectarBancoPostgress();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, cachorro.getNome());
            stmt.setString(2, cachorro.getRaca());
            stmt.setString(3, cachorro.getSexo());
            stmt.setString(4, cachorro.getPorte());
            stmt.setBoolean(5, cachorro.isAdotado());
            stmt.setInt(6, cachorro.getId());

            stmt.execute();

        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC não encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Erro SQL ao atualizar cachorro: " + e.getMessage());
        }
        return true;
    }

    public ArrayList<Cachorro> listarCachorro() {
        ArrayList<Cachorro> cachorros = new ArrayList<>();
        String sql = "SELECT * FROM cachorro";

        try (
                Connection conn = ConectarBancoDados.conectarBancoPostgress();
                Statement stmt    = conn.createStatement();
                ResultSet rs      = stmt.executeQuery(sql)
        ) {

            while (rs.next()) {
                Cachorro c = new Cachorro();
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setRaca(rs.getString("raca"));
                c.setSexo(rs.getString("sexo"));
                c.setPorte(rs.getString("porte"));
                c.setAdotado(rs.getBoolean("adotado"));

                cachorros.add(c);
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC não encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Erro ao listar cachorros: " + e.getMessage());
        }

        return cachorros;
    }

    public Cachorro buscarCachorroPorId(int id) {
        String sql = "SELECT * FROM cachorro WHERE id = ?";
        Cachorro cachorro = new Cachorro ();

        try (
                Connection conn = ConectarBancoDados.conectarBancoPostgress();
                PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cachorro = new Cachorro ();
                    cachorro.setId(rs.getInt("id"));
                    cachorro.setNome(rs.getString("nome"));
                    cachorro.setRaca(rs.getString("raca"));
                    cachorro.setSexo(rs.getString("sexo"));
                    cachorro.setPorte(rs.getString("porte"));
                    cachorro.setAdotado(rs.getBoolean("adotado"));
                }
            }

        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC não encontrado: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Erro ao buscar cachorro por ID: " + e.getMessage());
        }

        return cachorro;
    }

}
