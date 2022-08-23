<%-- 
    Document   : login
    Created on : Feb 12, 2022, 7:17:41 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="css/base.css">
        <script src="https://www.google.com/recaptcha/api.js"></script>
    </head>
    <body>
        <header>
            <a style="text-decoration: none;" href="shopping.jsp">                
                <img style="width: 20px;" src="image/store.jpg" alt="shop-image"/>
                SE160831 SHOP
            </a>
        </header>

        <h1>Login</h1>
        <form action="MainController" method="POST"></br>
            <input type="text" name="userID" required="" placeholder="Tên đăng nhập"/></br>
            <input type="password" name="password" required="" placeholder="Mật khẩu"/></br>
            <input type="submit" name="action" value="Login"/>
            <input type="reset" value="Reset"/>
            <div class="g-recaptcha"
                 data-sitekey="6Ldglp8hAAAAANHGE-KU1SETrYUVjrgUY7VLArq1"></div>
        </form>

        ${requestScope.ERROR}

    </body>
</html>
