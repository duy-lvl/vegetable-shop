<%-- 
    Document   : user
    Created on : Feb 12, 2022, 7:44:12 AM
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="shop.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
        <link rel="stylesheet" href="css/base.css">
    </head>
    <body>
        <header>
            <a href="shopping.jsp">SE160831 SHOP</a>
        </header>
        <h3>Your Information:</h3>
        
            
        <table border="0">   
            <tr>
                <td>User ID</td>
                <td>: ${sessionScope.LOGIN_USER.userID}</td>
            </tr>
            <tr>
                <td>Full name</td>
                <td>: ${sessionScope.LOGIN_USER.fullName}</td>
            </tr>
            <tr>
                <td>Role ID</td>
                <td>: ${sessionScope.LOGIN_USER.roleID}</td>
            </tr>
            <tr>
                <td>Password</td>
                <td>: ${"********"}</td>
            </tr>
        </table>
        
        <a href="MainController?action=Logout">Logout</a>
    </body>
</html>
