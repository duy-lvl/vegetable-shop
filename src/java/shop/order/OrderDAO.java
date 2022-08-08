/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shop.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import shop.product.ProductDTO;
import shop.utils.DBUtils;

/**
 *
 * @author USER
 */
public class OrderDAO {

    private final static String INSERT = "INSERT INTO tblOrders(orderDate, total, userID, status) "
            + "VALUES(?, ?, ?, ?)";
    private final static String INSERT_DETAIL = "INSERT INTO tblOrderDetail(price, quantity, orderID, productID) "
            + "VALUES(?, ?, ?, ?)";
    private final static String GET_ORDER_ID = "SELECT TOP 1 orderID FROM tblOrders WHERE userID LIKE ? ORDER BY orderID DESC";

    public boolean insert(OrderDTO order, List<ProductDTO> cartProducts) throws SQLException, ClassNotFoundException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setDate(1, order.getOrderDate());
                ptm.setDouble(2, order.getTotal());
                ptm.setString(3, order.getUserID());
                ptm.setDouble(4, order.getStatus());

                result = ptm.executeUpdate() > 0;

                if (result) {
                    int orderID = 0;
                    ptm = conn.prepareStatement(GET_ORDER_ID);
                    ptm.setString(1, order.getUserID());
                    rs = ptm.executeQuery();
                    if (rs.next()) {
                        orderID = rs.getInt("orderID");
                    }
                    
                    if (orderID > 0) {
                        for (ProductDTO product : cartProducts) {
                            ptm = conn.prepareStatement(INSERT_DETAIL);
                            ptm.setDouble(1, product.getPrice());
                            ptm.setInt(2, product.getQuantity());
                            ptm.setInt(3, orderID);
                            ptm.setString(4, product.getProductID());
                            result = ptm.executeUpdate() > 0;
                            
                        }
                    }
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public int getOrderID(String userID) throws ClassNotFoundException, SQLException {
        int orderID = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_ORDER_ID);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    orderID = rs.getInt("orderID");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return orderID;
    }

}
