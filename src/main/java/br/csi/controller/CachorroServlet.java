package br.csi.controller;
import br.csi.model.Cachorro;
import br.csi.model.Usuario;
import br.csi.service.CachorroService;
import br.csi.service.UsuarioService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("cachorro")
public class CachorroServlet extends HttpServlet {

    private static final CachorroService service = new CachorroService();

    @Override
    protected void doPost ( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException {

        HttpSession session = req.getSession();
        req.setCharacterEncoding("UTF-8"); // Definir encoding no início

        String opcao = req.getParameter("opcao");
        String id = req.getParameter("id");
        String nome = req.getParameter("nome");
        String raca = req.getParameter("raca");
        String sexo = req.getParameter("sexo");
        String porte = req.getParameter("porte");
        boolean adotado = Boolean.parseBoolean(req.getParameter("adotado"));

        Cachorro cachorro = new Cachorro();
        cachorro.setNome(nome);
        cachorro.setRaca(raca);
        cachorro.setSexo(sexo);
        cachorro.setPorte(porte);
        cachorro.setAdotado(adotado);

        String retorno;

        if ("atualizar".equals(opcao) && id != null) {
            cachorro.setId(Integer.parseInt ( id ));
            retorno = service.alterar(cachorro);
            session.setAttribute("msg", retorno);
            // redireciona para o form de edição (flash vai no session)
            resp.sendRedirect("cachorro");
            return;
        }

        // — INSERÇÃO —
        retorno = service.inserir(cachorro);
        session.setAttribute("msg", retorno);
        // redireciona para a listagem
        resp.sendRedirect("cachorro");

    }

    @Override
    protected void doGet ( HttpServletRequest req, HttpServletResponse resp ) throws ServletException, IOException {

        HttpSession session = req.getSession();
        // 1) se tiver flash na sessão, joga pro request e limpa
        String flash = (String) session.getAttribute("msg");
        if (flash != null) {
            req.setAttribute("msg", flash);
            session.removeAttribute("msg");
        }

        String opcao = req.getParameter("opcao");
        String info  = req.getParameter("info");

        if ("editar".equals(opcao) && info != null) {
            // — EXIBE FORM DE EDIÇÃO —
            int cachorroId = Integer.parseInt(info);
            Cachorro c  = service.buscar(cachorroId);
            req.setAttribute("cachorro", c);
            RequestDispatcher rd = req.getRequestDispatcher(
                    "WEB-INF/pages/alterarCachorro.jsp");
            rd.forward(req, resp);
            return;
        }

        if ("excluir".equals(opcao) && info != null) {
            // — EXCLUSÃO via redirect (flash na sessão) —
            String retorno = service.excluir(Integer.parseInt(info));
            session.setAttribute("msg", retorno);
            resp.sendRedirect("cachorro");
            return;
        }

        // — LISTAGEM PADRÃO —
        List<Cachorro> cachorros = service.listar();
        req.setAttribute("cachorros", cachorros);
        RequestDispatcher rd = req.getRequestDispatcher(
                "WEB-INF/pages/cachorros.jsp");
        rd.forward(req, resp);

    }
}
