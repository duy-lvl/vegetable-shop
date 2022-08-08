<%-- 
    Document   : shopping
    Created on : Feb 24, 2022, 12:39:17 PM
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="shop.product.ProductDTO"%>
<%@page import="shop.product.ProductDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="shop.user.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>
        <link rel="stylesheet" href="css/styleShopping.css">
        <link rel="stylesheet" href="css/base.css">
    </head>
    <body>
        <%
            //String userRole = ((UserDTO) (session.getAttribute("LOGIN_USER"))).getRoleID();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            
            
            if (loginUser != null) {
                if ("AD".equals(loginUser.getRoleID())) {
                    request.getRequestDispatcher("admin.jsp").forward(request, response);
                }
            }

        %>
        <c:if test="${requestScope.PRODUCT_LIST == null and requestScope.NOT_FOUND == null}">
            <% request.getRequestDispatcher("SearchController").forward(request, response);%>
        </c:if>


        <div class="header">

            <h1>Welcome to SE160831 Market!</h1>

            <div class="header-navbar">

                <ul class="header-navbar-list">
                    <li class="header-navbar-item">
                        <form action="MainController"> 
                            <input type="text" name="search" value="${param.search}"/>
                            <input type="hidden" name="roleID" value="US"/>
                            <input type="submit" name="action" value="Search"/>
                        </form>
                    </li>
                </ul>

                <ul class="header-navbar-list">

                    <li  class="header-navbar-item">
                        <a href="MainController?action=View">
                            <img class="icon-image" src="image/shoppingCart.jpg" alt="shopping-cart"/>
                        </a>
                    </li>


                    <c:if test="${sessionScope.LOGIN_USER == null}">
                        <li  class="header-navbar-item">
                            <a href="login.jsp">Login</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.LOGIN_USER != null}">
                        <li  class="header-navbar-item">
                            <a href="user.jsp">${sessionScope.LOGIN_USER.fullName}</a>
                        </li>
                        <li  class="header-navbar-item">
                            <a href="LogoutController">Log out</a>
                        </li>                    
                    </c:if>
                </ul>
            </div>
        </div>

        <p>${requestScope.LOGIN_MESSAGE}</p>

        <h4>${requestScope.NOT_FOUND}</h4>

        <div class="product">

            <c:if test="${requestScope.PRODUCT_LIST != null}">
                <c:if test="${not empty requestScope.PRODUCT_LIST}">
                    <c:forEach var="product" items="${requestScope.PRODUCT_LIST}">
                        <div class="product__detail">
                            <img src="${product.image}" alt="productImage">
                            <h4>${product.productName}</h4>
                            <p>${product.price} vnđ/kg</p>

                            <form action="MainController">
                                Số lượng (kg)
                                <select name="quantity">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                </select>
                                <input type="hidden" name="productID" value="${product.productID}"/>
                                <input type="hidden" name="productName" value="${product.productName}"/>
                                <input type="hidden" name="image" value="${product.image}"/>
                                <input type="hidden" name="price" value="${product.price}"/>
                                <input type="hidden" name="categoryID" value="${product.categoryID}"/>
                                <input type="hidden" name="importDate" value="${product.importDate}"/>
                                <input type="hidden" name="usingDate" value="${product.usingDate}"/>

                                <span class="product-quantity">${product.quantity}kg sản phẩm có sẵn</span>
                                <input <c:if test="${product.quantity == 0}">disabled </c:if>type="submit" name="action" value="Add"/>
                            </form>

                        </div>
                    </c:forEach>
                </c:if>
            </c:if>
        </div>
    </body>
</html>
