package br.csi.service;

import br.csi.dao.UsuarioDAO;
import br.csi.model.Usuario;
// Importe uma biblioteca de hashing, por exemplo, BCrypt
// import org.mindrot.jbcrypt.BCrypt; // Exemplo com jBCrypt

import java.util.ArrayList;

public class UsuarioService {

    private static UsuarioDAO dao = new UsuarioDAO();

    public String excluir(int id) {
        if (dao.excluir(id)) {
            return "Sucesso ao excluir usuário";
        } else {
            return "Erro ao excluir usuário";
        }
    }

    public ArrayList<Usuario> listar() {
        return dao.listar();
    }

    public Usuario buscar(int usuarioId) {
        return dao.buscar(usuarioId);
    }

    public String inserir(Usuario usuario) {
        // IMPORTANTE: A senha deve ser hasheada aqui antes de chamar o DAO
        // Exemplo:
        // if (usuario.getSenha() != null && !usuario.getSenha().isEmpty()) {
        //     String senhaHasheada = BCrypt.hashpw(usuario.getSenha(), BCrypt.gensalt());
        //     usuario.setSenha(senhaHasheada);
        // } else {
        //     // Lidar com senha vazia se for um requisito não permitir
        //     return "Erro: Senha não pode ser vazia.";
        // }
        System.out.println("Service - Inserindo Usuário: " + usuario.getEmail() + " Senha (ANTES DO DAO): " + usuario.getSenha()); // Log para debug
        if (dao.inserir(usuario)) {
            return "Sucesso ao inserir usuário";
        } else {
            return "Erro ao inserir usuário";
        }
    }

    public String alterar(Usuario usuario, boolean alterarSenha) {
        // Se a senha não for para ser alterada (veio null do servlet),
        // precisamos buscar a senha atual do banco para não sobrescrevê-la com null.
        if (!alterarSenha) {
            Usuario usuarioExistente = dao.buscar(usuario.getId()); // Assume que buscar(id) não retorna a senha ou retorna a hasheada
            if (usuarioExistente != null) {
                // Para garantir que a senha não seja alterada para null se não for fornecida
                // precisamos que o DAO.alterar seja inteligente ou que passemos a senha antiga.
                // Se o DAO.buscar(id) não retorna a senha, esta abordagem não funciona para manter a senha.
                // SOLUÇÃO MAIS SEGURA: O DAO.alterar não deve atualizar o campo senha se o valor no objeto for null.
                // OU, o service busca o usuário completo (com senha hasheada), aplica as alterações
                // e só muda a senha se uma nova foi fornecida e hasheada.

                // Abordagem: Se não for alterar senha, não passamos a senha para o DAO (ou passamos a antiga)
                // Se o seu DAO.alterar atualiza todos os campos, incluindo a senha,
                // e usuario.getSenha() for null aqui, ele vai tentar setar a senha como null no banco.
                // Vamos assumir que o DAO.alterar foi ajustado para não mudar a senha se ela for null no objeto.
                // Se não, a melhor forma é:
                Usuario usuarioDB = dao.buscar(usuario.getId()); // Este buscar DEVE retornar a senha hasheada
                if(usuarioDB != null) {
                    usuario.setSenha(usuarioDB.getSenha()); // Mantém a senha antiga se não for para alterar
                } else {
                    return "Erro: Usuário não encontrado para manter senha.";
                }
            } else {
                return "Erro: Usuário não encontrado para manter senha.";
            }
        } else {
            // Se for para alterar a senha, ela já deve ter vindo do servlet (e idealmente hasheada lá ou aqui)
            // IMPORTANTE: HASHEAR A SENHA AQUI se não foi feito no servlet
            // Exemplo:
            // if (usuario.getSenha() != null && !usuario.getSenha().isEmpty()) {
            //     String senhaHasheada = BCrypt.hashpw(usuario.getSenha(), BCrypt.gensalt());
            //     usuario.setSenha(senhaHasheada);
            // } else {
            //     return "Erro: Nova senha inválida.";
            // }
            System.out.println("Service - Alterando Usuário: " + usuario.getEmail() + " Nova Senha (ANTES DO DAO): " + usuario.getSenha()); // Log para debug
        }


        if (dao.alterar(usuario)) {
            return "Sucesso ao alterar usuário";
        } else {
            return "Erro ao alterar usuário";
        }
    }
}
