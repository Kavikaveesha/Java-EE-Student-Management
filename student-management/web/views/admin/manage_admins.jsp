<%@page import="com.studentManagement.model.Admin"%>
<%@page import="java.util.List"%>
<%@page import="com.studentManagement.utill.assetsUrl"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Management System - Manage Admins</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=assetsUrl.giveUrl(request, "css/style.css")%>"/>
        <style>
            body {
                background-color: #f8f9fa; 
                overflow-x: hidden;
            }

            h1 {
                color: black;
                font-weight: bold;
            }

            .btn-primary {
                background-color: #1976D2; 
                border: none;
            }

            .btn-lg {
                padding: 1rem 2rem;
                font-size: 1.2rem;
            }

            .table-container {
                /* Container for the table, allowing overflow */
                max-height:400px; /* Adjust as needed */
                overflow-y: auto;
                margin-right: 10rem;
            }

            .table {
                /* Optional: Adjust table styling */
                width: 100%;
            }

            .table td {
                /* Optional: Adjust cell styling */
                padding: 1rem;
            }
            button a:hover{
                color: white;
                text-decoration: none;
                padding: 1.1rem 2rem;


            }
        </style>
    </head>
    <body>
        <%
            // Assuming mIDList is a List<MealItems> passed as a request attribute
            List<Admin> admins = (List<Admin>) request.getAttribute("adminList");
        %>
        <%@ include file="/views/common/navbar.jspf" %>

        <div class="container-fluid m-5 mt-5">
            <h1 class="mb-4">Admins Management</h1>
            <button class="btn btn-primary mb-4">
                <a href="${pageContext.request.contextPath}/manage-admin/admin-registration">Add New Admin</a></button>
                <% if (admins != null && !admins.isEmpty()) { %>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Admin ID</th>
                            <th>Name</th>
                            <th>Email</th> 
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Admin admin : admins) {%>
                        <tr style="border-bottom: 1px solid #222222;"> 
                            <td><%= admin.getAdminId()%></td>
                            <td><%= admin.getAdminName()%></td>
                            <td><%= admin.getEmail()%></td>
                            <td>
                                <a href="manage-admin/update-admin?id=<%= admin.getAdminId()%>" class="btn btn-primary" style="width: 3.5rem;font-size: .5rem">Edit</a>
                                <a href="#" 
                                   onclick="return confirmDelete('<%=  admin.getAdminId()%>');"
                                   class="btn btn-danger" style="width: 3.5rem;font-size: .5rem">Delete</a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="alert alert-info" role="alert">
                No Admins to display.
            </div>
            <% }%>
        </div>

        <%@ include file="/views/common/footer.jspf" %>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
        <script>
                                       function confirmDelete(adminId) {
                                           // Display a confirmation dialog using SweetAlert
                                           swal({
                                               title: "Are you sure?",
                                               text: "Once deleted, you will not be able to recover this item!",
                                               icon: "warning",
                                               buttons: true,
                                               dangerMode: true,
                                           }).then(function (willDelete) {
                                               if (willDelete) {
                                                   // Redirect to the delete action with the item ID
                                                   window.location.href = "${pageContext.request.contextPath}/manage-admin/delete-admin?id=" + adminId;
                                               } else {
                                                   // Do nothing if the user cancels
                                               }
                                           });
                                           // Return false to prevent the default link action
                                           return false;
                                       }
        </script>
    </body>
</html>