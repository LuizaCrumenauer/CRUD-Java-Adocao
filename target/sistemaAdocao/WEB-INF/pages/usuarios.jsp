<%-- WEB-INF/pages/usuarios.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciamento de Usuários</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa; /* Cor de fundo suave */
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 1100px; /* Aumentado para tabelas largas */
            margin: 20px auto;
            padding: 25px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h2 {
            color: #0056b3; /* Azul escuro para o título principal */
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.8em;
        }
        .message-feedback {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: 500;
        }
        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        th, td {
            border: 1px solid #dee2e6; /* Borda mais suave */
            padding: 12px 15px; /* Mais padding para melhor leitura */
            text-align: left;
            vertical-align: middle;
        }
        th {
            background-color: #e9ecef; /* Cabeçalho da tabela com cor suave */
            color: #495057;
            font-weight: 600; /* Fonte um pouco mais forte */
            text-transform: uppercase;
            font-size: 0.85em;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa; /* Linhas alternadas */
        }
        tr:hover {
            background-color: #f1f3f5; /* Efeito hover sutil */
        }
        td.actions { /* Adicionado para melhor controle da célula de ações */
            white-space: nowrap; /* Impede que os botões quebrem para a linha de baixo se não houver espaço */
        }
        .actions a {
            text-decoration: none;
            padding: 6px 12px;
            margin-right: 8px;
            border-radius: 4px;
            font-size: 0.9em;
            transition: opacity 0.2s ease;
            display: inline-block; /* Garante que fiquem na mesma linha e respeitem margens */
            margin-bottom: 5px; /* Adiciona um pequeno espaço se eles quebrarem em telas muito pequenas */
        }
        .actions a:last-child {
            margin-right: 0; /* Remove margem do último botão na linha */
        }
        .actions a:hover {
            opacity: 0.8;
        }
        .action-edit {
            background-color: #ffc107; /* Amarelo para editar */
            color: #212529;
            border: 1px solid #e0a800;
        }
        .action-delete {
            background-color: #dc3545; /* Vermelho para excluir */
            color: white;
            border: 1px solid #c82333;
        }
        .page-actions {
            margin-top: 30px; /* Aumentado o espaço */
            padding-top: 20px; /* Adicionado padding superior */
            border-top: 1px solid #eee; /* Linha separadora */
            text-align: center;
        }
        .page-actions a {
            text-decoration: none;
            margin: 0 10px;
            padding: 10px 20px; /* Botões um pouco maiores */
            border-radius: 5px; /* Bordas mais arredondadas */
            font-weight: 500;
            transition: background-color 0.2s ease, color 0.2s ease, box-shadow 0.2s ease;
            border: 1px solid transparent; /* Para manter o tamanho ao adicionar borda no hover */
        }
        .page-actions a:hover {
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        /* Cores específicas para os botões de rodapé */
        .action-voltar-dashboard {
            background-color: #6c757d; /* Cinza */
            color: white;
            border-color: #5a6268;
        }
        .action-voltar-dashboard:hover {
            background-color: #5a6268;
        }
        .action-cadastrar-admin {
            background-color: #28a745; /* Verde */
            color: white;
            border-color: #1e7e34;
        }
        .action-cadastrar-admin:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Gerenciamento de Usuários</h2>

    <c:if test="${not empty msg}">
        <div class="message-feedback ${msg.toLowerCase().contains('sucesso') ? 'success-message' : 'error-message'}">
            <p>${msg}</p>
        </div>
    </c:if>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>CPF</th>
            <th>Celular</th>
            <th>Endereço</th>
            <th>Admin?</th>
            <th>Ações</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="usuarioItem" items="${usuarios}">
            <tr>
                <td>${usuarioItem.id}</td>
                <td><c:out value="${usuarioItem.nome}"/></td>
                <td><c:out value="${usuarioItem.email}"/></td>
                <td><c:out value="${usuarioItem.cpf}"/></td>
                <td><c:out value="${usuarioItem.celular}"/></td>
                <td><c:out value="${usuarioItem.endereco}"/></td>
                <td>${usuarioItem.admin ? 'Sim' : 'Não'}</td>
                <td class="actions">
                    <a href="${pageContext.request.contextPath}/usuario?opcao=editar&info=${usuarioItem.id}" class="action-edit">Alterar</a>
                    <c:if test="${sessionScope.usuarioLogado.id != usuarioItem.id}">
                        <a href="${pageContext.request.contextPath}/usuario?opcao=excluir&info=${usuarioItem.id}"
                           class="action-delete"
                           onclick="return confirm('Tem certeza que deseja excluir o usuário ${usuarioItem.nome}?');">Excluir</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty usuarios}">
            <tr>
                <td colspan="8" style="text-align:center; padding: 20px;">Nenhum usuário cadastrado.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="page-actions">
        <a href="${pageContext.request.contextPath}/usuario?opcao=mostrarDashboardAdmin" class="action-voltar-dashboard">Voltar ao Dashboard</a>
        <a href="${pageContext.request.contextPath}/usuario?opcao=mostrarFormCadastroAdmin" class="action-cadastrar-admin">Cadastrar Novo Administrador</a>
    </div>
</div>
</body>
</html>
