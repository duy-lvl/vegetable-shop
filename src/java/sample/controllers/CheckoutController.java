/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.order.OrderDAO;
import sample.order.OrderDTO;
import sample.product.ProductDAO;
import sample.product.ProductDTO;
import sample.shopping.Cart;
import sample.user.UserDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "viewCart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            List<ProductDTO> productList = (List<ProductDTO>) cart.getProductList();
            boolean checkQuantity = true;
            ProductDAO dao = new ProductDAO();
            for (ProductDTO product : productList) {
                int maxQuantity = dao.getMaxQuantity(product.getProductID());
                checkQuantity = checkQuantity && (product.getQuantity() <= maxQuantity);
            }
            if (checkQuantity) {
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                Date orderDate = new Date(System.currentTimeMillis());
                double total = Double.parseDouble(request.getParameter("total"));
                byte status = 1;
                OrderDTO order = new OrderDTO(orderDate, total, loginUser.getUserID(), status);
                OrderDAO odao = new OrderDAO();
                boolean checkOrder = odao.insert(order, productList);
                for (ProductDTO product : productList) {
                    checkQuantity = checkQuantity && dao.updateProductQuantity(product.getProductID(), dao.getMaxQuantity(product.getProductID()) - product.getQuantity());
                }
                if (checkQuantity && checkOrder) {
                    session.removeAttribute("CART");
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Checkout successfully!");
                    return;
                }
                
            }
            request.setAttribute("MESSAGE", "Checkout failed!");
        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
            request.setAttribute("MESSAGE", "Checkout failed!");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
