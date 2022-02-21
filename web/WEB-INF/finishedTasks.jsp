<%@ page import="java.util.List" %>
<%@ page import="taskmanagment.model.User" %>
<%@ page import="taskmanagment.model.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="taskmanagment.model.TaskStatus" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 19.02.2022
  Time: 01:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Finished Tasks</title>
</head>
<body>
<%
    List<Task> finishedTasks = (List<Task>) request.getAttribute("finishedTasks");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<p>Finished Tasks</p>
<a href="/managerHome">Back</a>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Deadline</th>
        <th>Status</th>
        <th>User</th>


    </tr>
    <%
        for (Task task : finishedTasks) {


    %>
    <tr>


        <td><%=task.getId()%>
        </td>
        <td><%=task.getName()%>
        </td>
        <td><%=task.getDescription()%>
        </td>
        <td><%=sdf.format(task.getDeadline())%>
        </td>
        <td><%=task.getStatus().name()%>
        </td>
        <td><%=task.getUser().getName() + " " + task.getUser().getSurname()%>
        </td>
    </tr>


    <%

        }
    %>
</table>
</body>
</html>
