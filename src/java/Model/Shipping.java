/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author lenovo
 */
public class Shipping {
    int ShippingID;
    int OrderID;
    int CarrierID;
    String TrackingNumber;
    Date ShippingDate;
    Date EstimatedDeliveryDate;
    Date ActualDeliveryDate;
    String Status;

    public Shipping() {
    }

    public Shipping(int ShippingID, int OrderID, int CarrierID, String TrackingNumber, Date ShippingDate, Date EstimatedDeliveryDate, Date ActualDeliveryDate, String Status) {
        this.ShippingID = ShippingID;
        this.OrderID = OrderID;
        this.CarrierID = CarrierID;
        this.TrackingNumber = TrackingNumber;
        this.ShippingDate = ShippingDate;
        this.EstimatedDeliveryDate = EstimatedDeliveryDate;
        this.ActualDeliveryDate = ActualDeliveryDate;
        this.Status = Status;
    }

    public int getShippingID() {
        return ShippingID;
    }

    public void setShippingID(int ShippingID) {
        this.ShippingID = ShippingID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public int getCarrierID() {
        return CarrierID;
    }

    public void setCarrierID(int CarrierID) {
        this.CarrierID = CarrierID;
    }

    public String getTrackingNumber() {
        return TrackingNumber;
    }

    public void setTrackingNumber(String TrackingNumber) {
        this.TrackingNumber = TrackingNumber;
    }

    public Date getShippingDate() {
        return ShippingDate;
    }

    public void setShippingDate(Date ShippingDate) {
        this.ShippingDate = ShippingDate;
    }

    public Date getEstimatedDeliveryDate() {
        return EstimatedDeliveryDate;
    }

    public void setEstimatedDeliveryDate(Date EstimatedDeliveryDate) {
        this.EstimatedDeliveryDate = EstimatedDeliveryDate;
    }

    public Date getActualDeliveryDate() {
        return ActualDeliveryDate;
    }

    public void setActualDeliveryDate(Date ActualDeliveryDate) {
        this.ActualDeliveryDate = ActualDeliveryDate;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    @Override
    public String toString() {
        return "Shipping{" + "ShippingID=" + ShippingID + ", OrderID=" + OrderID + ", CarrierID=" + CarrierID + ", TrackingNumber=" + TrackingNumber + ", ShippingDate=" + ShippingDate + ", EstimatedDeliveryDate=" + EstimatedDeliveryDate + ", ActualDeliveryDate=" + ActualDeliveryDate + ", Status=" + Status + '}';
    }
    
}
