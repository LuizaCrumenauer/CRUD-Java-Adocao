<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Usuário</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 400px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: calc(100% - 12px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        input[type="submit"]:hover { background-color: #45a049; }
        .error-message { color: red; margin-bottom: 15px; }
        .back-link { margin-top: 15px; display: block; }
    </style>
</head>
<body>
<div class="container">
    <h2>Cadastre-se</h2>

    <c:if test="${not empty msg_erro_cadastro}">
        <p class="error-message">${msg_erro_cadastro}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/usuario" method="post">
        <%-- Não precisamos de "opcao=inserir" aqui, o doPost do UsuarioServlet tratará como inserção --%>

        <div>
            <label for="nome">Nome Completo:</label>
            <input type="text" id="nome" name="nome" value="${param.nome}" required>
        </div>
        <div>
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" value="${param.endereco}">
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" value="${param.cpf}">
        </div>
        <div>
            <label for="celular">Celular:</label>
            <input type="tel" id="celular" name="celular" value="${param.celular}">
        </div>
        <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" value="${param.email}" required>
        </div>
        <div>
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>
        <%-- Adicionar confirmação de senha é uma boa prática
        <div>
            <label for="confirmarSenha">Confirmar Senha:</label>
            <input type="password" id="confirmarSenha" name="confirmarSenha" required>
        </div>
        --%>
        <div>
            <input type="submit" value="Cadastrar">
        </div>
    </form>
    <a href="${pageContext.request.contextPath}/index.jsp" class="back-link">Voltar para Login</a>
</div>
</body>
</html>
