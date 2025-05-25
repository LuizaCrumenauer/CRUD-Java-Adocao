<%@page contentType="text/html; charset=UTF-8" language="java" %> <%-- Mudado para UTF-8 para melhor compatibilidade de caracteres --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Adoção</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        .login-container {
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-container h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 1.8em;
        }
        .login-container label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
            font-size: 0.95em;
        }
        .login-container input[type="email"],
        .login-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1em;
        }
        .login-container input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .login-container input[type="submit"]:hover {
            background-color: #2980b9;
        }
        .message-container {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
        }
        .error-message {
            color: #c0392b;
            background-color: #fdd;
            border: 1px solid #fbb;
        }
        .success-message {
            color: #27ae60;
            background-color: #e6ffed;
            border: 1px solid #c3e6cb;
        }
        .signup-link {
            margin-top: 25px;
            font-size: 0.95em;
        }
        .signup-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>LOGIN NO SISTEMA</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" placeholder="seu@email.com" name="email" required>
        </div>
        <div>
            <label for="senha">Senha:</label>
            <input type="password" id="senha" placeholder="Sua Senha" name="senha" required>
        </div>
        <input type="submit" value="LOGAR">
    </form>

    <%-- Mensagem de erro do login --%>
    <c:if test="${not empty msg}">
        <div class="message-container error-message">
            <p>${msg}</p>
        </div>
    </c:if>

    <%-- Mensagem de sucesso do cadastro (se houver) --%>
    <c:if test="${not empty msg_cadastro_sucesso}">
        <div class="message-container success-message">
            <p>${msg_cadastro_sucesso}</p>
        </div>
    </c:if>

    <div class="signup-link">
        Não tem uma conta? <a href="${pageContext.request.contextPath}/usuario?opcao=mostrarFormCadastro">Cadastre-se</a>
    </div>
</div>

</body>
</html>
