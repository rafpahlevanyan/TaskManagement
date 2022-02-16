package taskmanagment.Servlet;

import taskmanagment.manager.TaskManager;
import taskmanagment.model.Task;
import taskmanagment.model.TaskStatus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;


@WebServlet(urlPatterns = "/addTask")
public class AddTaskServlet extends HttpServlet { //vorn e ed jsp

    private TaskManager taskManager = new TaskManager();
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String date = req.getParameter("date");
        String status = req.getParameter("status");
        int userId = Integer.parseInt(req.getParameter("user_id"));


        try {
            taskManager.create(Task.builder()
                    .name(name)
                    .description(description)
                    .deadline(sdf.parse(date))
                    .status(TaskStatus.valueOf(status))
                    .userId(userId)
                    .build());
            resp.sendRedirect("/managerHome");
        } catch (ParseException e) {
            e.printStackTrace();
        }




    }

}
