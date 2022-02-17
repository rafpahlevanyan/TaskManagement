package taskmanagment.Servlet;

import taskmanagment.manager.TaskManager;
import taskmanagment.manager.UserManager;
import taskmanagment.model.Task;
import taskmanagment.model.User;
import taskmanagment.model.UserType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/managerHome")
public class ManagerHomeServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            TaskManager taskManager = new TaskManager();
            UserManager userManager = new UserManager();

            List<Task> allTasks = taskManager.getAllTasks();
        for (Task task : allTasks) {
            if(new Date().after(task.getDeadline())){
                task.setExpired(true);
            }
        }
            List<User> allUsers = userManager.getAllUsers();
            req.setAttribute("tasks", allTasks);
            req.setAttribute("users", allUsers);
            req.getRequestDispatcher("/WEB-INF/manager.jsp").forward(req, resp);
        }

    }


