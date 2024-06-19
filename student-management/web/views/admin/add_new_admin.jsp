<%@page import="com.studentManagement.utill.assetsUrl"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Registration</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=assetsUrl.giveUrl(request, "css/style.css")%>"/>
        <style>
            body {
                background-color: #f8f9fa; /* Light background for contrast */
            }

            h2 {
                color: black; /* Primary blue */
                font-weight: bold;
            }

            .btn-primary {
                background-color: #1976D2; /* Match primary color */
                border: none;
            }

            .btn-lg {
                padding: .5rem 2rem;
                font-size: 1.2rem;
            }

            .card {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add box shadow */
                border-radius: 10px; /* Add rounded corners */
            }
        </style>
    </head>
    <body>
        <%@ include file="/views/common/navbar.jspf" %>
        <div class="container mt-5">
            <div class="row justify-content-center"> <div class="col-md-8">
                    <div class="card"> <div class="card-body">
                            <h2>${Admin != null ? 'Update Admin Data' : 'Admin Registration'}</h2>

                            <form action="${Admin != null ? 'update-admin-method' : 'add-new-admin'}" method="post">
                                <input type="hidden" value="${Admin != null ? Admin.adminId : ''}" name="adminId">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="name">Name:</label>
                                        <input type="text" class="form-control" id="name" name="adminName" placeholder="Enter name" value="${Admin != null ? Admin.adminName : ''}">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="email">Email:</label>
                                        <input type="email" class="form-control" id="email" name="adminEmail" placeholder="Enter  email"value="${Admin != null ? Admin.email : ''}">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="password">Password:</label>
                                        <input type="password" class="form-control" id="password" name="adminPassword" placeholder="Enter password" value="${Admin != null ? Admin.password : ''}">
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBasic">Register</button>
                            </form>
                        </div>
                    </div> </div>
                    <%@ include file="/views/common/footer.jspf" %>

            </div>
            <input type="hidden" id="status" value="<%= request.getAttribute("status")%>"> 

            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                $(document).ready(function() {
                var status = document.getElementById("status").value;
                if (status === "CreateSuccess") {
                Swal.fire({
                icon: 'success',
                        title: 'Success!',
                        text: 'Successfully Registered an Admin',
                        confirmButtonColor: '#4CAF50', // Green button for success
                }).then((result) = > { // Corrected `then` function
                if (result.isConfirmed) {
                document.getElementById("submitBasic").disabled = true;
                }
                });
                } else if (status === "CreateFailed") {
                Swal.fire({
                icon: 'error',
                        title: 'Error!',
                        text: 'Error in Registering an Admin',
                        confirmButtonColor: '#f44336', // Red button for error
                });
                } else if (status === "InputInvalid") {
                Swal.fire({
                icon: 'error',
                        title: 'Error!',
                        text: 'Please fill all the inputs',
                        confirmButtonColor: '#f44336', // Red button for error
                });
                }
                // Add more status conditions here as needed
                });
            </script>
    </body>
</html>