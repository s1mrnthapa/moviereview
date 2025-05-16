package com.moviereview.model;

import java.util.Date;

public class Admin {
    private int id;
    private String name;
    private String email;
    private String username;
    private String role;
    private Date joinedDate;
    private Date lastLogin;
    
    // Constructors
    public Admin() {}
    
    public Admin(int id, String name, String email, String username, String role, Date joinedDate, Date lastLogin) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.username = username;
        this.role = role;
        this.joinedDate = joinedDate;
        this.lastLogin = lastLogin;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public Date getJoinedDate() {
        return joinedDate;
    }
    
    public void setJoinedDate(Date joinedDate) {
        this.joinedDate = joinedDate;
    }
    
    public Date getLastLogin() {
        return lastLogin;
    }
    
    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }
}