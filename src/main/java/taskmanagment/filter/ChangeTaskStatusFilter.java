package taskmanagment.filter;

import taskmanagment.model.User;
import taskmanagment.model.UserType;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/changeTaskStatus")
public class ChangeTaskStatusFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpSession session = request.getSession();
        HttpServletResponse response = (HttpServletResponse) servletResponse;


        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/index.jsp");
        } else if (user.getType() == UserType.MANAGER || user.getType() == UserType.USER) {
            filterChain.doFilter(servletRequest, servletResponse);
        }


    }

    @Override
    public void destroy() {

    }
}
