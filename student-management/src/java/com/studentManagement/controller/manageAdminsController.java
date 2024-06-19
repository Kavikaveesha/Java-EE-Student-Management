package com.studentManagement.controller;

import com.studentManagement.model.Admin;
import com.studentManagement.service.AdminService;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"/manage-admin", "/manage-admin/admin-registration",
    "/manage-admin/add-new-admin","/manage-admin/update-admin-method","/manage-admin/update-admin", "/manage-admin/delete-admin"})
public class manageAdminsController extends HttpServlet {

    private AdminService adminService;

    public manageAdminsController() {
        this.adminService = new AdminService();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/manage-admin":
                    listAdmins(request, response);
                    break;
                case "/manage-admin/admin-registration":
                    showNewForm(request, response);
                    break;
                case "/manage-admin/add-new-admin":
                    addNewAdmin(request, response);
                    break;
                case "/manage-admin/update-admin":
                    showEditForm(request, response);
                    break;
                case "/manage-admin/update-admin-method":
                    updateAdmin(request, response);
                    break;
                case "/manage-admin/delete-admin":
                    deleteAdmin(request, response);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void listAdmins(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Admin> adminList = adminService.showAdmins();
        request.setAttribute("adminList", adminList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/manage_admins.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/add_new_admin.jsp");
        dispatcher.forward(request, response);
    }

    // Add new admin method with null checks
    private void addNewAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String adminName = request.getParameter("adminName");
        String adminEmail = request.getParameter("adminEmail");
        String adminPassword = request.getParameter("adminPassword");

        // Null check before using variables
        if (adminName == null || adminName.isEmpty()
                || adminEmail == null || adminEmail.isEmpty()) {
            request.setAttribute("status", "InputInvalid");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/add_new_admin.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Admin newAdmin = new Admin(adminName, adminEmail, adminPassword);
        int created = adminService.addAdmin(newAdmin);

        if (created > 0) {
            request.setAttribute("status", "CreateSuccess");
        } else {
            request.setAttribute("status", "CreateFailed");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/add_new_admin.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Implement edit form display
        String id = request.getParameter("id"); // Get the ID of the item to edit
        // Fetch the item from the database using the DAO
        Admin admin = adminService.showAdminById(Integer.parseInt(id));
        request.setAttribute("Admin", admin);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/add_new_admin.jsp");
        dispatcher.forward(request, response);
    }

    private void updateAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        PrintWriter out = response.getWriter();
        String adminIdStr = request.getParameter("adminId");
        out.print(adminIdStr);

        int adminId = 0;
        if (adminIdStr != null && !adminIdStr.isEmpty()) {
            try {
                adminId = Integer.parseInt(adminIdStr);
            } catch (NumberFormatException e) {
                response.sendRedirect("error.jsp");
                return;
            }
        } else {
            response.sendRedirect("error.jsp");
            return;
        }
        String adminName = request.getParameter("adminName");
        String adminEmail = request.getParameter("adminEmail");
        String adminPassword = request.getParameter("adminPassword");
        out.println(adminId+adminName+adminName+adminPassword);

        Admin updatedAdmin = new Admin(adminId, adminName, adminEmail, adminPassword);

        boolean updated = adminService.updateAdmin(updatedAdmin);

        if (updated) {
            request.setAttribute("status", "UpdateSuccess");
        } else {
            request.setAttribute("status", "UpdateFailed");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-admin");
        dispatcher.forward(request, response);
    }

    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("id");
        adminService.deleteAdmin(Integer.parseInt(id));
        RequestDispatcher dispatcher = request.getRequestDispatcher("/manage-admin");
        dispatcher.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Admin management servlet";
    }
}
