package taskmanagment.Servlet;


import taskmanagment.manager.UserManager;
import taskmanagment.model.User;
import taskmanagment.model.UserType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = "/addUser")
public class AddUserServlet extends HttpServlet {

    private UserManager userManager = new UserManager();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String name = req.getParameter("name");
        String surname = req.getParameter("surname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String type = req.getParameter("type");

        userManager.add(User.builder()
                        .name(name)
                        .surname(surname)
                        .email(email)
                        .password(password)
                        .type(UserType.valueOf(type))
                .build());

        resp.sendRedirect("/managerHome");

    }
}
