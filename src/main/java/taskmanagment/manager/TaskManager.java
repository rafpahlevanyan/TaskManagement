package taskmanagment.manager;

import com.mysql.cj.result.SqlDateValueFactory;
import taskmanagment.db.DBConnectionProvider;
import taskmanagment.model.Task;
import taskmanagment.model.TaskStatus;
import taskmanagment.model.User;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class TaskManager {
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private Connection connection = DBConnectionProvider.getInstance().getConnection();
    private UserManager userManager = new UserManager();


    public boolean create(Task task) {
        String sql = "INSERT INTO task(name,description," +
                "deadline,status,user_id) VALUES(?,?,?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, task.getName());
            statement.setString(2, task.getDescription());
            statement.setString(3, sdf.format(task.getDeadline()));
            statement.setString(4, task.getStatus().name());
            statement.setInt(5, task.getUserId());
            statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                task.setId(rs.getInt(1));
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }



    public Task getById(int id) {
        String sql = "SELECT * FROM task WHERE id = " + id;
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if (resultSet.next()) {
                return getTaskFromResultSet(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateTaskStatus(int taskId, String newStatus) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE task SET status = ? where id = ?");
            preparedStatement.setString(1, newStatus);
            preparedStatement.setInt(2, taskId);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public boolean delete(int id) {
        String sql = "DELETE FROM task WHERE id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Task getTaskFromResultSet(ResultSet resultSet) {
        Task task = new Task();
        try {
            try {
                return Task
                        .builder()
                        .id(resultSet.getInt(1))
                        .name(resultSet.getString(2))
                        .description(resultSet.getString(3))
                        .deadline(sdf.parse(resultSet.getString(4)))
                        .status(TaskStatus.valueOf(resultSet.getString(5)))
                        .userId(resultSet.getInt(6))
                        .user(userManager.getUserById(resultSet.getInt(6)))
                        .build();
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    public List<Task> getAllTasksByUser(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM task WHERE user_id = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1,userId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                tasks.add(getTaskFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public List<Task> getAllTasksByUserAndStatus(long userId, TaskStatus status) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM task WHERE user_id = ? AND status = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setLong(1, userId);
            statement.setString(2, status.name());
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                tasks.add(getTaskFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }


    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM task";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                tasks.add(getTaskFromResultSet(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }

    public boolean changeTaskDeadline(int id, String date) {
        String sql = "UPDATE task SET deadline = ? WHERE id = ?";
        try{
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,date);
            statement.setInt(2,id);
            statement.executeUpdate();
            return true;
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
}
