<%@ page import="java.util.Date" %>
<%@ page import="java.io.File" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>files</title>
</head>

<body>
<p>Текущее время: <%= new Date() %></p>
<p>Текущая папка: <%= request.getAttribute("path") %></p>
<ul>
    <%
        String path = (String) request.getParameter("path");
        String login = (String) request.getAttribute("login");

        String parentPath = new File(path).getParent();
        if(parentPath == null || !parentPath.contains("C:/test/" + login + "/")){
            parentPath = "C:\\test\\" + login;
        }
    %>
    <li>
        <a href="files?path=<%= parentPath.replace("\\", "/") %>"> На уровень выше </a>
    </li>
    <%
    File[] files = (File[]) request.getAttribute("files");
    for (File file : files) {
        String filePath = file.getAbsolutePath().replace("\\", "/");
        if (file.isDirectory()) {
            %>
                <li>
                    [Папка] <a href="files?path=<%= filePath %>"> <%= file.getName() %> </a>
                </li>
            <%
        }
        else {
            %>
                <li>
                    [Файл] <a href="download?path=<%= filePath %>"> <%= file.getName() %> </a>
                </li>
            <%
        }
    }
    %>
</ul>

<form action="files" method="POST">
    <input type="submit" value="Выйти">
</form>

</body>
</html>