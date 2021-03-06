package taskmanagment.Servlet;

import taskmanagment.manager.TaskManager;
import taskmanagment.manager.UserManager;
import taskmanagment.model.Task;
import taskmanagment.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet(urlPatterns = "/userHome")
public class UserHomeServlet extends HttpServlet {

    private TaskManager taskManager = new TaskManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");


        List<Task> allTaskByUserId = taskManager.getAllTasksByUser(user.getId());
        for (Task task : allTaskByUserId) {
            if (new Date().after(task.getDeadline())) {
                task.setExpired(true);
            }
        }

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.DATE, 3);
        Date beforeThreeDays = calendar.getTime();
        for (Task task : allTaskByUserId) {
            if (task.getDeadline().before(beforeThreeDays) && task.getDeadline().after(new Date())) {
                task.setCloseToExpire(true);
            }
        }

        req.setAttribute("tasks", allTaskByUserId);
        req.getRequestDispatcher("/WEB-INF/user.jsp").forward(req, resp);
    }


}

