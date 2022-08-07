<%-- 
    Document   : view
    Created on : Feb 24, 2022, 1:16:05 PM
    Author     : USER
--%>

<%@page import="sample.user.UserDTO"%>
<%@page import="sample.product.ProductDTO"%>
<%@page import="sample.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping cart</title>
        <link rel="stylesheet" href="css/styleViewCart.css">
        <link rel="stylesheet" href="css/base.css">
    </head>
    <body>
        <a style="text-decoration: none;" href="shopping.jsp">                
            <img style="width: 20px; height: 20px;" src="image/store.jpg" alt="shop-image"/>
            SE160831 SHOP
        </a>
        <h1>Your selected product:</h1>
        <%
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null) {
        %>
        <table border="1" style="border-collapse: collapse;">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Unit price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Remove</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    double total = 0;
                    for (ProductDTO product : cart.getCart().values()) {
                        total += product.getPrice() * product.getQuantity();
                %>
            <form action="MainController">
                <tr>
                <input type="hidden" name="productID" value="<%= product.getProductID()%>"/>
                <td><%= count++%></td>
                <td>
                    <img src="<%= product.getImage()%>" alt="product-image"/>
                </td>
                <td>
                    <%= product.getProductName()%>
                </td>
                <td>
                    <%= product.getPrice()%>
                </td>
                <td>
                    <input type="number" name="quantity" value="<%= product.getQuantity()%>" min="1" required=""/>
                </td>
                <td>
                    <%= product.getPrice() * product.getQuantity()%>vnđ
                </td>
                <td>
                    <input type="submit" name ="action" value="Remove"/>
                </td>
                <td>
                    <input type="submit" name ="action" value="Edit"/>
                </td>
                </tr>
            </form>    
            <%
                }
            %>

        </tbody>
    </table>
    <h2>Total: <%= total%>vnđ</h2>


    <form action="MainController">
        <input type="hidden" name="total" value="<%= total%>"/>
        <input type="submit" name="action" value="Checkout"/>
    </form>
    <%
        }
    %>
    ${requestScope.MESSAGE}
    ${requestScope.EDIT_MESSAGE}
</body>
</html>
