/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author lenovo
 */
public class Carriers {
    int CarrierID;
    String CarrierName;
    String ContactInfo;

    public Carriers() {
    }

    public Carriers(int CarrierID, String CarrierName, String ContactInfo) {
        this.CarrierID = CarrierID;
        this.CarrierName = CarrierName;
        this.ContactInfo = ContactInfo;
    }

    public int getCarrierID() {
        return CarrierID;
    }

    public void setCarrierID(int CarrierID) {
        this.CarrierID = CarrierID;
    }

    public String getCarrierName() {
        return CarrierName;
    }

    public void setCarrierName(String CarrierName) {
        this.CarrierName = CarrierName;
    }

    public String getContactInfo() {
        return ContactInfo;
    }

    public void setContactInfo(String ContactInfo) {
        this.ContactInfo = ContactInfo;
    }

    @Override
    public String toString() {
        return "Carriers{" + "CarrierID=" + CarrierID + ", CarrierName=" + CarrierName + ", ContactInfo=" + ContactInfo + '}';
    }
    
}
