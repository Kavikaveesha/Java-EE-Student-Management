/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.studentManagement.controller;

import com.studentManagement.service.AdminService;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author kavin
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class authController extends HttpServlet {
    private  AdminService adminService;
    
    public  authController(){
        this.adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/auth/login.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter(); // For debugging

        // Debugging: Check if values are received correctly
        out.println("Email: " + email);
        out.println("Password: " + password);
        // Debugging: Check if database connection is established (you'll need to implement this)

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "You must fill both inputs");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/auth/login.jsp");
            dispatcher.forward(request, response);
        } else {
            HttpSession session = request.getSession();

            if (adminService.loginAdmin(email, password, session)) {
                // Login successful, redirect to the admin dashboard or another page
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Login failed, redirect to the login page with an error message
                request.setAttribute("error", "Invalid email or password");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/auth/login.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

