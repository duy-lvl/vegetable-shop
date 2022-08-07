/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.order;

import java.sql.Date;

/**
 *
 * @author USER
 */
public class OrderDTO {

    private Date orderDate;
    private double total;
    private String userID;
    private byte status;

    public OrderDTO() {
    }

    public OrderDTO(Date orderDate, double total, String userID, byte status) {
        this.orderDate = orderDate;
        this.total = total;
        this.userID = userID;
        this.status = status;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

}
