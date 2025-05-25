<%-- WEB-INF/pages/alterarUsuario.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>Alterar Usuário</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        .container { width: 450px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="email"], input[type="tel"], input[type="password"], select {
            width: calc(100% - 16px); /* Ajustado para padding */
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"], .cancel-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 1em;
        }
        .cancel-button { background-color: #6c757d; margin-left:10px;}
        input[type="submit"]:hover { background-color: #0056b3; }
        .cancel-button:hover { background-color: #5a6268;}
        .message { padding: 10px; margin-bottom:15px; border-radius:4px; }
        .success-message { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
        .error-message { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
        .password-note { font-size: 0.9em; color: #555; margin-bottom: 15px;}
    </style>
</head>
<body>
<div class="container">
    <h2>Alterar Usuário: <c:out value="${usuario.nome}"/></h2>

    <c:if test="${not empty msg}">
        <p class="message ${msg.toLowerCase().contains('sucesso') ? 'success-message' : 'error-message'}">${msg}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/usuario" method="post">
        <input type="hidden" name="opcao" value="atualizar">
        <input type="hidden" name="id" value="${usuario.id}">

        <div>
            <label for="nome">Nome Completo:</label>
            <input type="text" id="nome" name="nome" value="<c:out value="${usuario.nome}"/>" required>
        </div>
        <div>
            <label for="endereco">Endereço:</label>
            <input type="text" id="endereco" name="endereco" value="<c:out value="${usuario.endereco}"/>">
        </div>
        <div>
            <label for="cpf">CPF:</label>
            <input type="text" id="cpf" name="cpf" value="<c:out value="${usuario.cpf}"/>">
        </div>
        <div>
            <label for="celular">Celular:</label>
            <input type="tel" id="celular" name="celular" value="<c:out value="${usuario.celular}"/>">
        </div>
        <div>
            <label for="email">E-mail:</label>
            <input type="email" id="email" name="email" value="<c:out value="${usuario.email}"/>" required>
        </div>
        <div>
            <label for="admin">Tipo de Usuário:</label>
            <select id="admin" name="admin">
                <option value="false" ${!usuario.admin ? 'selected' : ''}>Comum</option>
                <option value="true" ${usuario.admin ? 'selected' : ''}>Administrador</option>
            </select>
        </div>

        <hr style="margin: 20px 0;">
        <p class="password-note">Deixe os campos de senha em branco se não desejar alterá-la.</p>
        <div>
            <label for="novaSenha">Nova Senha:</label>
            <input type="password" id="novaSenha" name="novaSenha">
        </div>
        <div>
            <label for="confirmarNovaSenha">Confirmar Nova Senha:</label>
            <input type="password" id="confirmarNovaSenha" name="confirmarNovaSenha">
        </div>
        <hr style="margin-top: 20px; margin-bottom: 20px;">

        <div>
            <input type="submit" value="Salvar Alterações">
            <a href="${pageContext.request.contextPath}/usuario?opcao=listarTodos" class="cancel-button">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>
