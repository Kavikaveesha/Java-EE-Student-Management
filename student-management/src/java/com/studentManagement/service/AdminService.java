package com.studentManagement.service;

import com.studentManagement.model.Admin;
import com.studentManagement.utill.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

public class AdminService {
    
   


    private static final String INSERT_QUERY = "INSERT INTO admins (adminName, email, password) VALUES (?, ?, ?)";
    private static final String UPDATE_QUERY = "UPDATE admins SET adminName = ?, email = ?, password = ? WHERE adminId = ?";
    private static final String DELETE_QUERY = "DELETE FROM admins WHERE adminId = ?";
    private static final String SELECT_BY_ID_QUERY = "SELECT * FROM admins WHERE adminId = ?";
    private static final String SELECT_ALL_QUERY = "SELECT * FROM admins";
    private static final String SELECT_BY_EMAIL_QUERY = "SELECT * FROM admins WHERE email = ?";

    // Add a new admin
    public int addAdmin(Admin admin) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, admin.getAdminName());
            statement.setString(2, admin.getEmail());
            statement.setString(3, admin.getPassword());

            statement.executeUpdate();

            ResultSet generatedKeys = statement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1); // Get the generated adminId
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Error adding admin
    }

    // Update an existing admin
    public boolean updateAdmin(Admin admin) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(UPDATE_QUERY)) {
            statement.setString(1, admin.getAdminName());
            statement.setString(2, admin.getEmail());
            statement.setString(3, admin.getPassword());
            statement.setInt(4, admin.getAdminId());

            return statement.executeUpdate() > 0; // True if update successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Error updating admin
    }

    // Get all admins
    public List<Admin> showAdmins() {
        List<Admin> adminsList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_ALL_QUERY);
                ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                Admin admin = mapResultSetToAdmin(resultSet);
                adminsList.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return adminsList;
    }

    // Get an admin by ID
    public Admin showAdminById(int adminId) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_BY_ID_QUERY)) {
            statement.setInt(1, adminId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToAdmin(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Admin not found
    }

    // Delete an admin
    public boolean deleteAdmin(int adminId) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(DELETE_QUERY)) {
            statement.setInt(1, adminId);
            return statement.executeUpdate() > 0; // True if delete successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Error deleting admin
    }

    // Admin login
    public boolean loginAdmin(String email, String password, HttpSession session) {
        try (Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(SELECT_BY_EMAIL_QUERY)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String storedPassword = resultSet.getString("password");
                if (storedPassword.equals(password)) {
                    Admin admin = mapResultSetToAdmin(resultSet);
                    session.setAttribute("loggedInAdmin", admin);
                    return true; // Login successful
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Invalid credentials
    }

    // Admin logout
    public void logoutAdmin(HttpSession session) {
        session.invalidate();
    }

    // Helper method to map ResultSet to Admin object
    private Admin mapResultSetToAdmin(ResultSet resultSet) throws SQLException {
        int adminId = resultSet.getInt("adminId");
        String adminName = resultSet.getString("adminName");
        String email = resultSet.getString("email");
        String password = resultSet.getString("password");
        return new Admin(adminId, adminName, email, password);
    }
}