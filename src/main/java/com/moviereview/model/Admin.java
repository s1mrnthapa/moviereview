package com.moviereview.model;

public class Admin {
    private int adminId;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String role;
    private java.sql.Timestamp registerDate;

    // Empty constructor
    public Admin() {}

    // Constructor
    public Admin(int adminId, String username, String firstName, String lastName,
                 String email, String password, java.sql.Timestamp registerDate, String role) {
        this.adminId = adminId;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.registerDate = registerDate;
        this.role = role;
    }

    // Getters and Setters
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public java.sql.Timestamp getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(java.sql.Timestamp registerDate) {
        this.registerDate = registerDate;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
