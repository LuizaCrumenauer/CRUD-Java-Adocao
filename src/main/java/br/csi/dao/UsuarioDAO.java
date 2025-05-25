package br.csi.dao;

import br.csi.model.Cachorro;
import br.csi.model.Usuario;

import java.sql.*;
import java.util.ArrayList;

public class UsuarioDAO {

    // Método para verificar se um email já existe (útil antes de inserir)
    // Este método já estava correto na sua versão anterior, mas o incluo para contexto.
    public boolean emailJaExiste(String email) {
        String sql = "SELECT id FROM usuario WHERE email = ?";
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // Retorna true se encontrou algum registro (email existe)
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Erro ao verificar email no DAO: " + e.getMessage());
            e.printStackTrace();
            // Em caso de erro na verificação, pode ser mais seguro assumir que existe
            // para evitar inserções duplicadas se a verificação falhar.
            return true; // Ou false, dependendo da sua política de erro.
            // Se retornar true aqui, a inserção será bloqueada.
        }
    }

    public Boolean inserir(Usuario usuario) {
        // Opcional: Verificar se o email já existe aqui, embora o service possa fazer isso.
        // Se o banco tiver uma constraint UNIQUE no email, ele lançará uma SQLException de qualquer forma.
        // if (emailJaExiste(usuario.getEmail())) {
        //     System.out.println("DAO: Tentativa de inserir usuário com email já existente: " + usuario.getEmail());
        //     return false;
        // }

        String sql = "INSERT INTO usuario (nome, endereco, cpf, celular, email, senha, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?)";
        System.out.println("DAO: Tentando inserir usuário: " + usuario.getEmail() + ", isAdmin: " + usuario.isAdmin());
        try (Connection conn = ConectarBancoDados.conectarBancoPostgress();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEndereco());
            stmt.setString(3, usuario.getCpf());
            stmt.setString(4, usuario.getCelular());
            stmt.setString(5, usuario.getEmail());
            stmt.setString(6, usuario.getSenha()); // Lembre-se: HASHEAR A SENHA ANTES DE CHEGAR AQUI!
            stmt.setBoolean(7, usuario.isAdmin());

            int affectedRows = stmt.executeUpdate(); // Usar executeUpdate() e verificar o retorno

            if (affectedRows > 0) {
                System.out.println("DAO: Usuário inserido com sucesso. Linhas afetadas: " + affectedRows);
                return true; // Sucesso se uma ou mais linhas foram afetadas
            } else {
                System.out.println("DAO: Nenhuma linha foi inserida para o usuário: " + usuario.getEmail());
                return false; // Nenhuma linha afetada (pode indicar um problema, embora raro para INSERT sem WHERE)
            }

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("DAO: Erro ao inserir usuário: " + e.getMessage());
            // Verificar se é erro de constraint UNIQUE para email ou cpf
            if (e instanceof SQLException) {
                SQLException sqlEx = (SQLException) e;
                System.err.println("DAO: SQLState: " + sqlEx.getSQLState());
                System.err.println("DAO: Error Code: " + sqlEx.getErrorCode());
                // No PostgreSQL, um erro de violação de constraint UNIQUE geralmente tem SQLState '23505'
                if ("23505".equals(sqlEx.getSQLState())) {
                    System.err.println("DAO: Provável violação de constraint UNIQUE (ex: email ou CPF já existe).");
                }
            }
            e.printStackTrace(); // Imprimir o stack trace completo para debug
            return false; // Retorna false em caso de exceção
        }
    }

    public Boolean alterar( Usuario usuario) {
        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress ();
            PreparedStatement stmt = conn.prepareStatement
                    ( "UPDATE usuario SET nome = ? ,endereco = ?, cpf = ?, celular = ?, email = ?, senha = ?, isAdmin = ? WHERE id = ? " );

            stmt.setString (1, usuario.getNome());
            stmt.setString (2, usuario.getEndereco());
            stmt.setString (3, usuario.getCpf());
            stmt.setString (4, usuario.getCelular());
            stmt.setString (5, usuario.getEmail());
            stmt.setString (6, usuario.getSenha());
            stmt.setBoolean ( 7, usuario.isAdmin () );
            stmt.setInt ( 8, usuario.getId () );

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException | ClassNotFoundException e) {
            System.err.println ( "DAO: Erro ao alterar usuário: " + e.getMessage () );
            if (e instanceof SQLException) {
                SQLException sqlEx = (SQLException) e;
                // No PostgreSQL, um erro de violação de constraint UNIQUE geralmente tem SQLState '23505'
                if ("23505".equals ( sqlEx.getSQLState () )) {
                    System.err.println ( "DAO: Provável violação de constraint UNIQUE ao alterar (ex: email ou CPF já existe para outro usuário)." );
                }
            }
            e.printStackTrace ();
            return false;
        }
    }

    public Boolean excluir ( int id) {

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress ();
            PreparedStatement stmt = conn.prepareStatement ( "DELETE FROM usuario WHERE id = ? " );

            stmt.setInt ( 1, id );
            stmt.execute ();

        }catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
            System.out.println("Erro ao excluir usuario");
        }

        return true;
    }

    public ArrayList<Usuario> listar() {

        ArrayList<Usuario> usuarios = new ArrayList<>();

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress ();
            Statement stmt = conn.createStatement();

            ResultSet rs = stmt.executeQuery("select * from usuario");
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setEndereco(rs.getString("endereco"));
                u.setCpf(rs.getString("cpf"));
                u.setCelular(rs.getString("celular"));
                u.setEmail(rs.getString("email"));
                u.setSenha(rs.getString("senha"));
                u.setAdmin(rs.getBoolean("isAdmin"));

                usuarios.add(u);
            }

        } catch (SQLException e) {
            System.out.println("Erro ao conectar");
            e.printStackTrace();
        } catch (ClassNotFoundException ex) {
            System.out.println("Drive não carregou");
            ex.printStackTrace();
        }

        return usuarios;

    }

    public Usuario buscar ( int id) {

        Usuario usuario = new Usuario ();

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress ();
            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM usuario WHERE id = ?"
            );

            stmt.setInt ( 1, id );

            ResultSet rs = stmt.executeQuery();
            if ( rs.next() ) {
                usuario.setId (rs.getInt ( "id" ) );
                usuario.setNome ( rs.getString ( "nome" ) );
                usuario.setEndereco ( rs.getString ( "endereco" ) );
                usuario.setCpf ( rs.getString ( "cpf" ) );
                usuario.setCelular ( rs.getString ( "celular" ) );
                usuario.setEmail ( rs.getString ( "email" ) );
                usuario.setSenha ( rs.getString ( "senha" ) );
                usuario.setAdmin ( rs.getBoolean ( "isAdmin" ) );
            }

            stmt.setInt(1, id);
        }catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
            System.out.println("Erro ao buscar usuario");
        }

        return usuario;

    }

    public Usuario buscar ( String email ) {
        Usuario usuario = new Usuario ();

        try {
            Connection conn = ConectarBancoDados.conectarBancoPostgress ();
            PreparedStatement stmt = conn.prepareStatement(
                    "SELECT * FROM usuario WHERE email = ?"
            );

            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome ( rs.getString("nome"));
                usuario.setEndereco ( rs.getString("endereco"));
                usuario.setCpf ( rs.getString("cpf"));
                usuario.setCelular ( rs.getString("celular"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setAdmin (rs.getBoolean ( "isAdmin" ) );

            }

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
            System.out.println("Erro ao buscar usuario");
        }

        return usuario;
    }



}
