package taskmanagment.Servlet;


import taskmanagment.manager.TaskManager;
import taskmanagment.manager.UserManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = "/deleteTask")
public class DeleteTaskServlet extends HttpServlet {

    private TaskManager taskManager = new TaskManager();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");
        int id = Integer.parseInt(idStr);

        taskManager.delete(id);
        resp.sendRedirect("/tasks");

    }
}
