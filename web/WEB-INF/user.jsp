<%@ page import="taskmanagment.model.Task" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="taskmanagment.model.TaskStatus" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 16.02.2022
  Time: 20:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Home</title>
</head>
<body>
<% List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");%>
<a href="/logout">Logout</a>


<div>
    <p>All Tasks</p>

    <table border="1">
        <tr>
            <td>ID</td>
            <th>Name</th>
            <th>Description</th>
            <th>Deadline</th>
            <th>Status</th>
            <th>User</th>
            <th>Change Status</th>


        </tr>

        <%for (Task task : tasks) {
            if (task.getStatus()== TaskStatus.FINISHED) {%>
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
            <td>
                <form action="/changeTaskStatus" method="post">
                    <input type="hidden" name="taskId" value="<%=task.getId()%>">
                    <select name="status">
                        <option value="NEW">NEW</option>
                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                        <option value="FINISHED">FINISHED</option>
                    </select><br>
                    <input type="submit" value="Change">
                </form>
            </td>
        </tr>


        <%
        }  else if (task.isExpired()) {%>
        <tr style="background-color: red">
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
            <td>
                <form action="/changeTaskStatus" method="post">
                    <input type="hidden" name="taskId" value="<%=task.getId()%>">
                    <select name="status">
                        <option value="NEW">NEW</option>
                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                        <option value="FINISHED">FINISHED</option>
                    </select><br>
                    <input type="submit" value="Change">
                </form>
            </td>
        </tr>


        <%
        }
        else if (task.isCloseToExpire()) {%>
        <tr style="background-color: orange">
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
            <td>
                <form action="/changeTaskStatus" method="post">
                    <input type="hidden" name="taskId" value="<%=task.getId()%>">
                    <select name="status">
                        <option value="NEW">NEW</option>
                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                        <option value="FINISHED">FINISHED</option>
                    </select><br>
                    <input type="submit" value="Change">
                </form>
            </td>
        </tr>


        <%
        }

        else {
        %>
        <tr style="background-color: green">
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
            <td>
                <form action="/changeTaskStatus" method="post">
                    <input type="hidden" name="taskId" value="<%=task.getId()%>">
                    <select name="status">
                        <option value="NEW">NEW</option>
                        <option value="IN_PROGRESS">IN_PROGRESS</option>
                        <option value="FINISHED">FINISHED</option>
                    </select><br>
                    <input type="submit" value="Change">
                </form>
            </td>

        </tr>

        <%
                }
            }
        %>
    </table>

</div>





</body>
</html>
