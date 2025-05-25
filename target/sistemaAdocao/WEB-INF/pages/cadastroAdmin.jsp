<%-- WEB-INF/pages/cadastroAdmin.jsp --%>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Novo Administrador</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 100%;
            max-width: 450px; /* Um pouco mais largo para formulários */
            margin: 20px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            color: #0056b3; /* Azul escuro para o título */
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.7em;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600; /* Labels um pouco mais fortes */
            color: #495057;
            font-size: 0.95em;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="tel"] {
            width: calc(100% - 22px); /* Considera padding e borda */
            padding: 10px;
            margin-bottom: 18px; /* Mais espaço entre os campos */
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1em;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.05em;
            font-weight: bold;
            /*width: 100%;*/
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .message-feedback { /* Para mensagens de erro/sucesso */
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-weight: 500;
        }
        .error-message { /* Classe específica para erro */
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        .back-link-container {
            /*text-align: center;*/
            margin-top: 25px;
        }
        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d; /* Cinza para voltar */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 0.95em;
            transition: background-color 0.3s ease;
        }
        .back-link:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Cadastrar Novo Administrador</h2>

    <c:if test="${not empty msg_erro_cadastro_admin}">
        <div class="message-feedback error-message">
            <p>${msg_erro_cadastro_admin}</p>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/usuario" method="post">
        <input type="hidden" name="acao" value="cadastrarAdmin">

        <div>
            <label for="nome">Nome Completo:</label>
            <input type="text" id="nome" name="nome" value="<c:out value="${param.nome}"/>" required>
        </div>
        <div>
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" value="<c:out value="${param.endereco}"/>">
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" value="<c:out value="${param.cpf}"/>">
        </div>
        <div>
            <label for="celular">Celular:</label>
            <input type="tel" id="celular" name="celular" value="<c:out value="${param.celular}"/>">
        </div>
        <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" value="<c:out value="${param.email}"/>" required>
        </div>
        <div>
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>
        <div style="margin-top: 10px;"> <%-- Pequeno ajuste de espaço antes do botão --%>
            <input type="submit" value="Cadastrar Administrador">
        </div>
    </form>
    <div class="back-link-container">
        <a href="${pageContext.request.contextPath}/usuario?opcao=mostrarDashboardAdmin" class="back-link">Voltar ao Dashboard</a>
    </div>
</div>
</body>
</html>
