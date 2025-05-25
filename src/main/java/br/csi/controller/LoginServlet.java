package br.csi.controller;


import br.csi.model.Usuario;
import br.csi.service.LoginService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        System.out.println("Email: "+email+" - senha: "+senha);

        RequestDispatcher dispatcher;

        Usuario usuarioAutenticado = new LoginService().autenticar(email, senha);

        if (usuarioAutenticado != null) {
            // Usuário autenticado
            System.out.println("Usuário autenticado: " + usuarioAutenticado.getEmail() + ", isAdmin: " + usuarioAutenticado.isAdmin());

            // Criar ou obter a sessão e armazenar o usuário
            HttpSession session = req.getSession();
            session.setAttribute("usuarioLogado", usuarioAutenticado);
            session.setAttribute("tipoUsuario", usuarioAutenticado.isAdmin() ? "admin" : "comum"); // Opcional, para fácil acesso no JSP

            if (usuarioAutenticado.isAdmin()) {
                // Redirecionar para a página de administrador
                System.out.println("Redirecionando para dashboard_admin.jsp");
                dispatcher = req.getRequestDispatcher("WEB-INF/pages/dashboard_admin.jsp");
            } else {
                // Redirecionar para a página de usuário comum
                System.out.println("Redirecionando para dashboard_usuario.jsp");
                dispatcher = req.getRequestDispatcher("WEB-INF/pages/dashboard_usuario.jsp");
            }
        } else {
            // Falha na autenticação
            System.out.println("Falha na autenticação para o email: " + email);
            req.setAttribute("msg", "Login ou senha incorreto!");
            dispatcher = req.getRequestDispatcher("index.jsp");
        }
        dispatcher.forward(req, resp);

    }

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("Execuntado o servelt login...");
//
//        PrintWriter out = resp.getWriter();
//        out.println("<html>");
//        out.println("<body>");
//
//        out.println("<h1>LISTA DE USUARIOS</h1>");
//
//        for(Usuario u : new UsuarioService().listar()){
//            out.println("<h3>");
//            out.println("Email: "+u.getEmail());
//            out.println("</h3>");
//        }
//        out.println("</body>");
//        out.println("</html>");
//
//    }
}
