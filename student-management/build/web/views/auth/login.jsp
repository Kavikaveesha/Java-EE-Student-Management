<%@page import="com.studentManagement.utill.assetsUrl"%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Management System - Login</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=assetsUrl.giveUrl(request, "css/style.css")%>"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background-color: #f8f9fa; /* Light background for contrast */
            }

            .container {
                /* No need for background color here, as it's in the card now */
                /* color: white; */
            }

            .card {
                background-color: white;
                border: none;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-body {
                padding: 3rem; /* Adjust padding as needed */
            }

            h2 {
                font-weight: bold;
                color: #1976D2; /* Primary blue */
            }

            .btn-primary {
                background-color: #1976D2; /* Match primary color */
                border: none;
            }

            .btn-lg {
                padding: .6rem 6rem;
                font-size: 1.2rem;
            }
        </style>
    </head>
    <body>

        <div class="container mt-5">
            <div class="row justify-content-center" style="margin-top: 20%;">
                <div class="col-md-8">
                    <div class="card shadow-lg rounded">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <img src="<%=assetsUrl.giveUrl(request, "images/img1.png")%>" alt="Student Management" class="img-fluid">
                                </div>
                                <div class="col-md-6 d-flex flex-column justify-content-center">
                                    <h2 class="mb-4">Login</h2>
                                    <form action="login" method="post">
                                        <div class="form-group">
                                            <label for="email">Email Address:</label>
                                            <input type="email" class="form-control" name="email" placeholder="Enter your email">
                                        </div>
                                        <div class="form-group">
                                            <label for="password">Password:</label>
                                            <input type="password" class="form-control" name="password" placeholder="Enter your password">
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-lg">Login</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>

            // Check if there's an error message and display it using SweetAlert
            if (errorMessage && errorMessage.trim() !== "") {
                Swal.fire({
                    icon: 'error',
                    title: 'Oops...',
                    text: errorMessage,
                });
            }


        </script> 

    </body>
</html>