/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import static sample.utils.DBUtils.getConnection;

/**
 *
 * @author USER
 */
public class ProductDAO {

    private static final String PRODUCT_LIST = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate "
            + "FROM tblProduct";

    private static final String UPDATE = "UPDATE tblProduct SET productName = ?, image = ?, price = ?, quantity = ?, categoryID = ?, importDate = ?, usingDate = ? "
            + "WHERE productID = ?";
    private static final String UPDATE_QUANTITY = "UPDATE tblProduct SET quantity = ? "
            + "WHERE productID = ?";

    private static final String DELETE = "DELETE tblProduct WHERE productID = ?";

    private static final String SEARCH = "SELECT productID, productName, image, price, quantity, categoryID, importDate, usingDate "
            + "FROM tblProduct "
            + "WHERE productName like ?";

    private static final String INSERT = "INSERT tblProduct (productID, productName, image, price, quantity, categoryID, importDate, usingDate) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_CATEGORY = "SELECT categoryID, categoryName FROM tblCategory";
    private static final String GET_MAX_QUANTITY = "SELECT quantity FROM tblProduct WHERE productID = ?";
    private static final String AD = "AD";
    private static final String US = "US";

    public List<ProductDTO> getProductList(String search, String roleID) throws SQLException, NamingException, ClassNotFoundException {
        List<ProductDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                if ("".equals(search)) {
                    stm = conn.prepareStatement(PRODUCT_LIST);
                } else {
                    stm = conn.prepareStatement(SEARCH);
                    stm.setString(1, "%" + search + "%");
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = Double.parseDouble(rs.getString("price"));
                    int quantity = Integer.parseInt(rs.getString("quantity"));
                    String categoryID = rs.getString("categoryID");
                    Date importDate = Date.valueOf(rs.getString("importDate"));
                    Date usingDate = Date.valueOf(rs.getString("usingDate"));
                    if (AD.equals(roleID)) {
                        ProductDTO product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                        list.add(product);
                    } else if (US.equals(roleID)) {
                        if (usingDate.after(new Date(System.currentTimeMillis()))) {
                            ProductDTO product = new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, usingDate);
                            list.add(product);
                        }
                    }

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
        return list;
    }

    
//    UPDATE tblProduct SET productName = ?, image = ?, price = ?, quantity = ?, categoryID = ?, importDate = ?, usingDate = ? 
//            + "WHERE productID = ?";

    public boolean updateProduct(ProductDTO product) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, product.getProductName());
                ptm.setString(2, product.getImage());
                ptm.setDouble(3, product.getPrice());
                ptm.setInt(4, product.getQuantity());
                ptm.setString(5, product.getCategoryID());
                ptm.setDate(6, product.getImportDate());
                ptm.setDate(7, product.getUsingDate());
                ptm.setString(8, product.getProductID());
                result = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public boolean deleteProduct(String productID) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE);
                ptm.setString(1, productID);
                result = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }

    public boolean addProduct(ProductDTO product) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, product.getProductID());
                ptm.setString(2, product.getProductName());
                ptm.setString(3, product.getImage());
                ptm.setDouble(4, product.getPrice());
                ptm.setInt(5, product.getQuantity());
                ptm.setString(6, product.getCategoryID());
                ptm.setDate(7, product.getImportDate());
                ptm.setDate(8, product.getUsingDate());
                result = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
    public Map<String, String> getCategory() throws SQLException, ClassNotFoundException {
        Map map = new HashMap();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_CATEGORY);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String cateID = rs.getString("categoryID");
                    String cateName = rs.getString("categoryName");
                    map.put(cateID, cateName);
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
        return map;
    }
    public int getMaxQuantity(String productID) throws SQLException, ClassNotFoundException {
        int result = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(GET_MAX_QUANTITY);
                stm.setString(1, productID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    result = rs.getInt("quantity");
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
        return result;
    }
    
    public boolean updateProductQuantity(String productID, int quantity) throws SQLException {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_QUANTITY);
                ptm.setInt(1, quantity);
                ptm.setString(2, productID);
                result = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return result;
    }
}
