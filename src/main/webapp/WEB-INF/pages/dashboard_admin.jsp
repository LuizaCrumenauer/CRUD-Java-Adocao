<%-- WEB-INF/pages/dashboard_admin.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Administrador</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #eef1f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .header {
            background-color: #2c3e50;
            color: #ecf0f1;
            padding: 20px 40px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 2em;
        }
        .container {
            max-width: 960px;
            margin: 30px auto;
            padding: 25px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        .welcome-message {
            font-size: 1.2em;
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .welcome-message strong {
            color: #3498db;
        }
        .management-section {
            margin-bottom: 30px;
        }
        .management-section h2 {
            color: #34495e;
            font-size: 1.6em;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 8px;
            display: inline-block;
        }
        .management-section ul {
            list-style: none;
            padding: 0;
        }
        .management-section li {
            margin-bottom: 12px;
        }
        .management-section a {
            text-decoration: none;
            color: #2980b9;
            font-size: 1.1em;
            padding: 8px 0;
            display: block;
            transition: color 0.2s ease-in-out, padding-left 0.2s ease-in-out;
        }
        .management-section a:hover {
            color: #1abc9c;
            padding-left: 5px;
        }
        .logout-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .logout-link:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Painel do Administrador</h1>
</div>

<div class="container">
    <%-- Blocos de mensagem foram removidos conforme solicitado --%>

    <p class="welcome-message">Bem-vindo(a), <strong><c:out value="${sessionScope.usuarioLogado.nome}"/></strong>!</p>

    <div class="management-section">
        <h2>Gerenciamento de Usuários</h2>
        <ul>
            <li><a href="${pageContext.request.contextPath}/usuario?opcao=mostrarFormCadastroAdmin">Cadastrar Novo Administrador</a></li>
            <li><a href="${pageContext.request.contextPath}/usuario?opcao=listarTodos">Ver/Gerenciar Todos os Usuários</a></li>
            <%-- Link de Gerenciar Cachorros restaurado conforme o pedido --%>

        </ul>
    </div>


        <div class="management-section">
            <h2>Gerenciamento de Cachorros</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/cachorro">Gerenciar Cachorros</a></li>
            </ul>
        </div>

    <hr style="margin-top: 30px; margin-bottom: 20px; border: 0; border-top: 1px solid #eee;">

    <div style="text-align: center;">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logout-link">Sair</a>
    </div>
</div>

</body>
</html>
