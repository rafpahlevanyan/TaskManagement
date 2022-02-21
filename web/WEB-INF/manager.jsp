<%@ page import="java.util.List" %>
<%@ page import="taskmanagment.model.User" %>
<%@ page import="taskmanagment.model.Task" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="taskmanagment.model.TaskStatus" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 16.02.2022
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
<%
    List<User> users = (List<User>) request.getAttribute("users");
    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    User user2 = (User) session.getAttribute("user");
%>
Welcome <%=user2.getName()%> <% if (user2.getPictureUrl()!=null){%>
    <img src="/image?path=<%=user2.getPictureUrl()%>" style="width: 100px"/><%}%>
<a href="/logout">Logout</a>


<div style="width: 700px">
    <div style="width: 350px;float: left">
        <p>ADD USER:</p>
        <form action="/addUser" method="post" enctype="multipart/form-data">
            <input type="text" name="name" placeholder="name"><br>
            <input type="text" name="surname" placeholder="surname"><br>
            <input type="email" name="email" placeholder="email"><br>
            <input type="password" name="password" placeholder="password"><br>
            <input type="file" name="image"><br>
            <select name="type">
                <option value="USER">USER</option>
                <option value="MANAGER">MANAGER</option>
            </select><br>
            <input type="submit" value="Add User"><br>
        </form>
    </div>
    <div style="width: 350px;float: left">
        <p>ADD TASK:</p>
        <form action="/addTask" method="post">
            <input type="text" name="name" placeholder="name"><br>
            <textarea name="description" placeholder="description"></textarea><br>
            <input type="date" name="date"><br>
            <select name="status">
                <option value="NEW">NEW</option>
                <option value="IN_PROGRESS">IN_PROGRESS</option>
                <option value="FINISHED">FINISHED</option>
            </select><br>
            <select name="user_id">
                    <%

                    for (User user : users) { %>

                <option value="<%=user.getId()%>"><%=user.getName()%><%=user.getSurname()%>

                </option>
                    <%
                    }

                %>
                <input type="submit" value="Add Task"><br>
        </form>
    </div>
</div>
<div>
    <p>All Users</p><br>
    <table border="1">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Surname</th>
            <th>Email</th>
            <th>Type</th>
            <th>Action</th>
        </tr>
        <%
            for (User user : users) { %>
        <tr>
            <td><%=user.getId()%>
            </td>
            <td><%=user.getName()%>
            </td>
            <td><%=user.getSurname()%>
            </td>
            <td><%=user.getEmail()%>
            </td>
            <td><%=user.getType().name()%>
            </td>
            <td><a href="/deleteUser?id=<%=user.getId()%>">Delete</a></td>
        </tr>
        <%
            }
        %>
    </table>

</div>
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
            <th>Change Deadline</th>
            <th>Change Status</th>
            <th>Action</th>

        </tr>

        <a href="/finishedTasks">Finished Tasks</a>>

        <%
            for (Task task : tasks) {
                if (task.getStatus() == TaskStatus.FINISHED) {
        %>
        <%--        <tr hidden>--%>
        <%--            <td><%=task.getId()%>--%>
        <%--            </td>--%>
        <%--            <td><%=task.getName()%>--%>
        <%--            </td>--%>
        <%--            <td><%=task.getDescription()%>--%>
        <%--            </td>--%>
        <%--            <td><%=sdf.format(task.getDeadline())%>--%>
        <%--            </td>--%>
        <%--            <td><%=task.getStatus().name()%>--%>
        <%--            </td>--%>
        <%--            <td><%=task.getUser().getName() + " " + task.getUser().getSurname()%>--%>
        <%--            </td>--%>
        <%--            <td>--%>
        <%--                <form action="/changeDeadline" method="post">--%>
        <%--                    <label>--%>
        <%--                        <input type="hidden" name="taskId" value="<%=task.getId()%>">--%>
        <%--                        <input type="date" value="<%=sdf.format(task.getDeadline())%>" name="date"><br>--%>
        <%--                        <input type="submit" value="Change">--%>
        <%--                    </label>--%>
        <%--                </form>--%>
        <%--            </td>--%>
        <%--            <td>--%>
        <%--                <form action="/changeTaskStatus" method="post">--%>
        <%--                    <input type="hidden" name="taskId" value="<%=task.getId()%>">--%>
        <%--                    <select name="status">--%>
        <%--                        <option value="NEW">NEW</option>--%>
        <%--                        <option value="IN_PROGRESS">IN_PROGRESS</option>--%>
        <%--                        <option value="FINISHED">FINISHED</option>--%>

        <%--                    </select><br>--%>
        <%--                    <input type="submit" value="Change">--%>
        <%--                </form>--%>
        <%--            </td>--%>
        <%--            <td><a href="/deleteTask?id=<%=task.getId()%>">Delete</a></td>--%>
        <%--        </tr>--%>


        <% } else if (task.isExpired()) {%>
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
                <form action="/changeDeadline" method="post">
                    <label>
                        <input type="hidden" name="taskId" value="<%=task.getId()%>">
                        <input type="date" value="<%=sdf.format(task.getDeadline())%>" name="date"><br>
                        <input type="submit" value="Change">
                    </label>
                </form>
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
            <td><a href="/deleteTask?id=<%=task.getId()%>">Delete</a></td>
        </tr>


        <%
        } else if (task.isCloseToExpire()) {%>
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
                <form action="/changeDeadline" method="post">
                    <label>
                        <input type="hidden" name="taskId" value="<%=task.getId()%>">
                        <input type="date" value="<%=sdf.format(task.getDeadline())%>" name="date"><br>
                        <input type="submit" value="Change">
                    </label>
                </form>
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
            <td><a href="/deleteTask?id=<%=task.getId()%>">Delete</a></td>
        </tr>


        <%
        } else {
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
                <form action="/changeDeadline" method="post">
                    <label>
                        <input type="hidden" name="taskId" value="<%=task.getId()%>">
                        <input type="date" value="<%=sdf.format(task.getDeadline())%>" name="date"><br>
                        <input type="submit" value="Change">
                    </label>
                </form>
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
            <td><a href="/deleteTask?id=<%=task.getId()%>">Delete</a></td>
        </tr>

        <%
                }
            }
        %>
    </table>

</div>


</body>
</html>
