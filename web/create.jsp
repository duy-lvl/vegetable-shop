<%-- 
    Document   : createUser
    Created on : Feb 22, 2022, 12:35:28 PM
    Author     : USER
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Page</title>
        <link rel="stylesheet" href="css/base.css">
    </head>
    <body>
        <a href="admin.jsp">Back to admin page</a>
        <h3>Create product</h3>
        <form action="MainController">
            <table border="0" style="border: none;">
                <tr>
                    <td>Product ID</td>
                    <td>
                        <input type="text" name="productID" required="Please fill in Product ID" placeholder="Enter product ID"/>
                    </td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>
                        <input type="text" name="productName" required="Please fill in Product Name" placeholder="Enter product name"/>
                    </td>
                </tr>
                <tr>
                    <td>Image</td>
                    <td>
                        <input type="text" name="image" required="Please fill in Product Image" placeholder="Enter product image"/>
                    </td>
                </tr>
                <tr>
                    <td>Price</td>
                    <td>
                        <input type="text" name="price" required="Please fill in Product Price" placeholder="Enter product price"/>
                    </td>
                </tr>
                <tr>
                    <td>Quantity</td>
                    <td>
                        <input type="text" name="quantity" required="Please fill in Product Quantity" placeholder="Enter product quantity"/>
                    </td>
                </tr>
                <tr>
                    <td>Category ID</td>
                    <td>

                        <select name="categoryID">

                            <%
                                Map<String, String> map = (Map<String, String>) request.getAttribute("CATEGORIES");
                                if (map != null) {
                                    Iterator cateIt = map.keySet().iterator();
                                    List<String> cateIDs = new ArrayList<>();
                                    while (cateIt.hasNext()) {
                                        cateIDs.add(cateIt.next().toString());
                                    }
                                    for (int i = 0; i < cateIDs.size(); i++) {
                            %>
                            <option value="<%= cateIDs.get(i)%>"><%= map.get(cateIDs.get(i))%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Import Date</td>
                    <td>
                        <input type="text" name="importDate" required="" placeholder="Enter product import date"/>
                    </td>
                </tr>
                <tr>
                    <td>Using Date</td>
                    <td>
                        <input type="text" name="usingDate" required="" placeholder="Enter product using date"/>
                    </td>
                </tr>

            </table>

            <input type="submit" name="action" value="Create"/>
            <input type="reset" value="Reset"/>
        </form>

        ${requestScope.MESSAGE}
    </body>
</html>
