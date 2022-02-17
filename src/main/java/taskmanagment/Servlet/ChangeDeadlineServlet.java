package taskmanagment.Servlet;

import taskmanagment.manager.TaskManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/changeDeadline")
public class ChangeDeadlineServlet extends HttpServlet {
    private final TaskManager taskManager = new TaskManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskId = req.getParameter("taskId");
        String date = req.getParameter("date");

        int id = Integer.parseInt(taskId);


        if (taskManager.changeTaskDeadline(id, date)) {
            resp.sendRedirect("/managerHome");
        }


    }
}
