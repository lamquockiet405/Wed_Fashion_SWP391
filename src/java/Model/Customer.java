package Model;

import java.util.Date;

/**
 *
 * @author lenovo
 */
public class Customer {
    private int CustomerID;
    private String Username;
    private String Password;
    private String Email;
    private String FirstName;
    private String LastName;
    private String Address;
    private Date DateOfBirth;
    private Boolean Gender;
    private String PhoneNumber;
    private String Image;
    private String Status;
    private Date CreatedAt;

    public Customer() {
    }

    public Customer(int CustomerID, String Username, String Password, String Email, String FirstName, String LastName, String Address, Date DateOfBirth, Boolean Gender, String PhoneNumber, String Image, String Status, Date CreatedAt) {
        this.CustomerID = CustomerID;
        this.Username = Username;
        this.Password = Password;
        this.Email = Email;
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Address = Address;
        this.DateOfBirth = DateOfBirth;
        this.Gender = Gender;
        this.PhoneNumber = PhoneNumber;
        this.Image = Image;
        this.Status = Status;
        this.CreatedAt = CreatedAt;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getFirstName() {
        return FirstName;
    }

    public void setFirstName(String FirstName) {
        this.FirstName = FirstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String LastName) {
        this.LastName = LastName;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public Date getDateOfBirth() {
        return DateOfBirth;
    }

    public void setDateOfBirth(Date DateOfBirth) {
        this.DateOfBirth = DateOfBirth;
    }

    public Boolean getGender() {
        return Gender;
    }

    public void setGender(Boolean Gender) {
        this.Gender = Gender;
    }

    public String getPhoneNumber() {
        return PhoneNumber;
    }

    public void setPhoneNumber(String PhoneNumber) {
        this.PhoneNumber = PhoneNumber;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String Image) {
        this.Image = Image;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Date getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Date CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    @Override
    public String toString() {
        return "Customer{" + "CustomerID=" + CustomerID + ", Username=" + Username + ", Password=" + Password + ", Email=" + Email + ", FirstName=" + FirstName + ", LastName=" + LastName + ", Address=" + Address + ", DateOfBirth=" + DateOfBirth + ", Gender=" + Gender + ", PhoneNumber=" + PhoneNumber + ", Image=" + Image + ", Status=" + Status + ", CreatedAt=" + CreatedAt + '}';
    }
}
