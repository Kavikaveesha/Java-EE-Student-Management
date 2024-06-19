<%@page import="com.studentManagement.model.Admin"%>
<%@page import="com.studentManagement.utill.assetsUrl"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Management System</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=assetsUrl.giveUrl(request, "css/style.css")%>"/>
    </head>
    <body style="overflow-y: hidden">

        <%
            // Check if admin is logged in (using session attribute)
            Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
        %>

        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <img src="<%=assetsUrl.giveUrl(request, "images/Student.png")%>" alt="Student Management" class="img-fluid" style="width: 4%;height: 4%">
                <a class="navbar-brand" href="#">Student Management</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav" style="display: flex;justify-content: flex-end">
                    <ul class="navbar-nav">
                        <% if (loggedInAdmin != null) {%>
                        <li class="nav-item dropdown">
                            <a class="nav-link"
                               data-bs-toggle="dropdown" aria-expanded="false"><%= loggedInAdmin.getAdminName()%></a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="#">Profile</a></li>
                                <li><a class="dropdown-item" href="#">Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout">Logout</a></li> </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/manage-admin">Admins</a>
                        </li>
                        <% } else {
                                // Redirect to login if not logged in
                                response.sendRedirect("login");
                        } %>
                    </ul>
                </div>
            </div>
        </nav>


        <% if (loggedInAdmin != null) {%>

        <div class="container-fluid " style="padding:0 5rem 5rem 5rem">
            <div class="row">
                <div class="col-md-6">
                    <img src="<%=assetsUrl.giveUrl(request, "images/img1.png")%>" alt="Student Management" class="img-fluid">
                </div>
                <div class="col-md-6 d-flex flex-column justify-content-center">
                    <h1>Welcome to the Student Management System</h1>
                    <p class="lead mt-4">
                        Manage your student data, track progress, and streamline your administrative tasks.
                    </p>
                    <div class="mt-4">
                        <a href="studentmanage.html" class="btn btn-primary btn-lg mr-3">Students</a>
                        <a href="teacherManagement.html" class="btn btn-outline-primary btn-lg">Teachers</a>
                    </div>
                </div>
            </div>
        </div>
        <% }%>
        
         <%@ include file="/views/common/footer.jspf" %>


        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>