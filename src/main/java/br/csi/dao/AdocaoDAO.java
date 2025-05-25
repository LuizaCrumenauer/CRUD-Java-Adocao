package br.csi.dao;

import br.csi.model.Adocao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdocaoDAO {

    public boolean inserirAdocao( Adocao adocao) {
        String sql = "INSERT INTO adocao (cachorro_id, adotante_id, informacoes) VALUES (?, ?, ?)";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adocao.getCachorroId());
            stmt.setInt(2, adocao.getAdotanteId());
            stmt.setString(3, adocao.getInformacoes ());

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao inserir adoção: " + e.getMessage());
        }
        return false;
    }

    public boolean excluirAdocao(int id) {
        String sql = "DELETE FROM adocao WHERE id = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao excluir adoção: " + e.getMessage());
        }
        return false;
    }

    public boolean alterarAdocao(Adocao adocao) {
        String sql = "UPDATE adocao SET cachorro_id = ?, adotante_id = ?, informacoes = ? WHERE id = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, adocao.getCachorroId());
            stmt.setInt(2, adocao.getAdotanteId());
            stmt.setString(3, adocao.getInformacoes ());
            stmt.setInt(4, adocao.getId());

            stmt.execute();

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao atualizar adoção: " + e.getMessage());
        }
        return false;
    }

    public List<Adocao> listarAdocoes() {
        List<Adocao> lista = new ArrayList<> ();
        String sql = "SELECT * FROM adocao";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Adocao a = new Adocao();
                a.setId(rs.getInt("id"));
                a.setCachorroId(rs.getInt("cachorro_id"));
                a.setAdotanteId(rs.getInt("adotante_id"));
                a.setInformacoes (rs.getString("informacoes"));
                lista.add(a);
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao listar adoções: " + e.getMessage());
        }
        return lista;
    }

    public Adocao buscarAdocaoPorId(int id) {
        String sql = "SELECT * FROM adocao WHERE id = ?";
        Adocao adocao = null;
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    adocao = new Adocao();
                    adocao.setId(rs.getInt("id"));
                    adocao.setCachorroId(rs.getInt("cachorro_id"));
                    adocao.setAdotanteId(rs.getInt("adotante_id"));
                    adocao.setInformacoes (rs.getString("informacoes"));
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Erro ao buscar adoção: " + e.getMessage());
        }
        return adocao;
    }

}
