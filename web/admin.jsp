<%-- 
    Document   : admin
    Created on : Feb 12, 2022, 7:52:00 AM
    Author     : USER
--%>

<%@page import="shop.user.UserDTO"%>
<%@page import="shop.product.ProductDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="css/styleAdminPage.css">
    </head>
    <body>
        <%
        UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
        if (loginUser == null || !loginUser.getRoleID().equals("AD")) {
            request.getRequestDispatcher("shopping.jsp").forward(request, response);
        }
        List<ProductDTO> productList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
        if (productList == null) {
            request.getRequestDispatcher("SearchController?roleID=AD").forward(request, response);
        }
        %>
        


        <div style="display: flex; justify-content: space-around;">
            <p>Welcome: ${sessionScope.LOGIN_USER.fullName}</p>

            <form style="padding-top: 15px;" action="MainController">
                <input type="submit" name="action" value="Logout"/>
            </form>
        </div>

        <br>
        <a href="GetCategoryController" class="add-new-image" style="display: flex;">
            <img src="image/create.jpg" alt="Add new product"/>
            <p>Add new Product</p>
        </a> 
        <br>

        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Category ID</th>
                    <th>Import date</th>
                    <th>Using date</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>

                <c:forEach var="product" items="${requestScope.PRODUCT_LIST}">

                <form action="MainController">
                    <tr>
                        <td>
                            ${product.productID}
                            <input type="hidden" name="productID" value="${product.productID}"/>
                        </td>
                        <td>
                            <img src="${product.image}" alt="product-image"/><br>
                            <input type="text"  name="image" value="${product.image}"/>
                        </td>
                        <td>
                            <input class="textbox" type="text" value="${product.productName}" name="productName"/>                        
                        </td>
                        <td>
                            <input class="textbox" type="text" name="price" value="${product.price}"/>
                        </td>
                        <td>
                            <input class="textbox" type="text" name="quantity" value="${product.quantity}"/>
                        </td>
                        <td>
                            <input class="textbox" type="text" name="categoryID" value="${product.categoryID}"/>
                        </td>
                        <td>
                            <input class="textbox" type="text" name="importDate" value="${product.importDate}"/>
                        </td>
                        <td>
                            <input class="textbox" type="text" name="usingDate" value="${product.usingDate}"/>
                        </td>
                        <td>
                            <input class="textbox" type="submit" name="action" value="Update"/>                        
                        </td>
                        <td>
                            <input class="textbox" type="submit" name="action" value="Delete"/>
                        </td>
                    </tr>

                </form>

            </c:forEach>

        </tbody>
    </table>

</body>
</html>
