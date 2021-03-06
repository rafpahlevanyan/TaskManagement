package taskmanagment.Servlet;

import taskmanagment.manager.TaskManager;
import taskmanagment.model.Task;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/finishedTasks")
public class FinishedTasks extends HttpServlet {
    private TaskManager taskManager = new TaskManager();


    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        List<Task> finishedTasks = taskManager.getAllFinishedTasks();

        req.setAttribute("finishedTasks", finishedTasks);
        req.getRequestDispatcher("/WEB-INF/finishedTasks.jsp").forward(req, resp);

    }
}
