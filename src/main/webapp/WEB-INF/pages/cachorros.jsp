<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>Gerenciar Cachorros</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; color: #333; }
        .container { max-width: 900px; margin: auto; background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2, h3 { color: #0056b3; text-align: center; }
        h3 { margin-top: 30px; border-bottom: 1px solid #eee; padding-bottom: 10px;}
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #dee2e6; padding: 10px; text-align: left; }
        th { background-color: #e9ecef; font-weight: bold; }
        tr:nth-child(even) { background-color: #f8f9fa; }
        label { display: block; margin-bottom: 6px; font-weight: 500; }
        input[type="text"], select {
            width: calc(100% - 22px);
            padding: 9px;
            margin-bottom: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-actions input[type="submit"], .button-link {
            background-color: #28a745;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.95em;
            margin-right: 10px;
        }
        .form-actions input[type="submit"]:hover { background-color: #218838; }
        .button-link.edit { background-color: #ffc107; color: #212529; }
        .button-link.edit:hover { background-color: #e0a800; }
        .button-link.delete { background-color: #dc3545; }
        .button-link.delete:hover { background-color: #c82333; }
        .button-link.dashboard { background-color: #6c757d; }
        .button-link.dashboard:hover { background-color: #5a6268; }
        .message { padding: 12px; margin-bottom: 20px; border-radius: 4px; text-align: center; font-weight:500; }
        .success-message { color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; }
        .error-message { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
        .form-group { margin-bottom: 0; } /* Reset margin for grid items */
    </style>
</head>
<body>
<div class="container">
    <h2>Gerenciamento de Cachorros</h2>
    <div>
        <a href="${pageContext.request.contextPath}/usuario?opcao=mostrarDashboardAdmin" class="button-link dashboard">Voltar ao Dashboard</a>
    </div>


        <c:if test="${not empty msg}">
            <p class="message ${msg.toLowerCase().contains('sucesso') ? 'success-message' : 'error-message'}">
                <c:out value="${msg}"/>
            </p>
        </c:if>


    <h3>Cadastrar Novo Cachorro</h3>
    <form action="${pageContext.request.contextPath}/cachorro" method="post">
        <%-- O campo 'acao' não é estritamente necessário se o doPost do CachorroServlet tratar POSTs sem 'opcao=atualizar' como inserção --%>
        <%-- <input type="hidden" name="acao" value="cadastrar"> --%>
        <div class="form-grid">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            <div class="form-group">
                <label for="raca">Raça:</label>
                <input type="text" id="raca" name="raca" required>
            </div>
            <div class="form-group">
                <label for="sexo">Sexo:</label>
                <select id="sexo" name="sexo" required>
                    <option value="">Selecione...</option>
                    <option value="Macho">Macho</option>
                    <option value="Fêmea">Fêmea</option>
                </select>
            </div>
            <div class="form-group">
                <label for="porte">Porte:</label>
                <select id="porte" name="porte" required>
                    <option value="">Selecione...</option>
                    <option value="Pequeno">Pequeno</option>
                    <option value="Médio">Médio</option>
                    <option value="Grande">Grande</option>
                </select>
            </div>
        </div>
        <%-- O status 'adotado' será false por padrão via CachorroService para novos cadastros --%>
        <div class="form-actions" style="margin-top: 20px;">
            <input type="submit" value="Cadastrar Cachorro">
        </div>
    </form>

    <h3>Cachorros Cadastrados</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Raça</th>
            <th>Sexo</th>
            <th>Porte</th>
            <th>Adotado?</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="dog" items="${cachorros}">
            <tr>
                <td>${dog.id}</td>
                <td><c:out value="${dog.nome}"/></td>
                <td><c:out value="${dog.raca}"/></td>
                <td><c:out value="${dog.sexo}"/></td>
                <td><c:out value="${dog.porte}"/></td>
                <td>${dog.adotado ? 'Sim' : 'Não'}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/cachorro?opcao=editar&info=${dog.id}" class="button-link edit">Alterar</a>
                    <a href="${pageContext.request.contextPath}/cachorro?opcao=excluir&info=${dog.id}" class="button-link delete"
                       onclick="return confirm('Tem certeza que deseja excluir o cachorro ${dog.nome}?');">Excluir</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty cachorros}">
            <tr>
                <td colspan="7" style="text-align:center;">Nenhum cachorro cadastrado.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>
