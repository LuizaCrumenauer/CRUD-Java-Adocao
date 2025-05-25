<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>Alterar Dados do Cachorro</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; color: #333; }
        .container { max-width: 500px; margin: auto; background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #0056b3; text-align: center; margin-bottom:20px; }
        label { display: block; margin-bottom: 6px; font-weight: 500; }
        input[type="text"], select {
            width: calc(100% - 22px);
            padding: 9px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="checkbox"] { margin-right: 5px; vertical-align: middle; }
        .checkbox-label { font-weight: normal; }
        .form-actions input[type="submit"], .button-link {
            background-color: #007bff;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.95em;
            margin-right: 10px;
        }
        .form-actions input[type="submit"]:hover { background-color: #0056b3; }
        .button-link.cancel { background-color: #6c757d; }
        .button-link.cancel:hover { background-color: #5a6268; }
        .message { padding: 12px; margin-bottom: 20px; border-radius: 4px; text-align: center; font-weight:500; }
        .error-message { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
<div class="container">
    <h2>Alterar Cachorro: <c:out value="${cachorro.nome}"/></h2>

    <c:if test="${not empty msg}">
        <p class="message ${msg.toLowerCase().contains('sucesso') ? 'success-message' : 'error-message'}">
            <c:out value="${msg}"/>
        </p>
    </c:if>

    <form action="${pageContext.request.contextPath}/cachorro" method="post">
        <input type="hidden" name="opcao" value="atualizar">
        <input type="hidden" name="id" value="${cachorro.id}"> <%-- Corrigido de id_cachorro para id para corresponder ao seu servlet --%>

        <div>
            <label for="nome">Nome:</label>
            <input type="text" id="nome" name="nome" value="<c:out value="${cachorro.nome}"/>" required>
        </div>
        <div>
            <label for="raca">Raça:</label>
            <input type="text" id="raca" name="raca" value="<c:out value="${cachorro.raca}"/>" required>
        </div>
        <div>
            <label for="sexo">Sexo:</label>
            <select id="sexo" name="sexo" required>
                <option value="Macho" ${cachorro.sexo == 'Macho' ? 'selected' : ''}>Macho</option>
                <option value="Fêmea" ${cachorro.sexo == 'Fêmea' ? 'selected' : ''}>Fêmea</option>
            </select>
        </div>
        <div>
            <label for="porte">Porte:</label>
            <select id="porte" name="porte" required>
                <option value="Pequeno" ${cachorro.porte == 'Pequeno' ? 'selected' : ''}>Pequeno</option>
                <option value="Médio" ${cachorro.porte == 'Médio' ? 'selected' : ''}>Médio</option>
                <option value="Grande" ${cachorro.porte == 'Grande' ? 'selected' : ''}>Grande</option>
            </select>
        </div>
        <div>
            <label for="adotado">
                <input type="checkbox" id="adotado" name="adotado" value="true" ${cachorro.adotado ? 'checked' : ''}>
                <span class="checkbox-label">Adotado</span>
            </label>
        </div>
        <div class="form-actions" style="margin-top: 20px;">
            <input type="submit" value="Salvar Alterações">
            <a href="${pageContext.request.contextPath}/cachorro" class="button-link cancel">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>
