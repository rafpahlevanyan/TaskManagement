package taskmanagment.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Task {

    private int id;
    private String name;
    private String description;
    private Date deadline;
    private TaskStatus status;
    private int userId;
    private User user;
    private boolean isExpired;




}
