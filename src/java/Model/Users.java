/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Dell
 */
public class Users {
    int UserID;
    String Username;
    String Password;
    String Email;
    String FirstName;
    String LastName;
    String Address;
    String DateOfBirth;
    boolean Gender;
    String PhoneNumber;
    String Image;
    String UserRole;
    String Status;
    String CreateAt;

    public Users() {
    }

    public Users(int UserID, String Username, String Password, String Email, String FirstName, String LastName, String Address, String DateOfBirth, boolean Gender, String PhoneNumber, String Image, String UserRole, String Status, String CreateAt) {
        this.UserID = UserID;
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
        this.UserRole = UserRole;
        this.Status = Status;
        this.CreateAt = CreateAt;
    }

    public int getUserID() {
        return UserID;
    }

    public void setUserID(int UserID) {
        this.UserID = UserID;
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

    public String getDateOfBirth() {
        return DateOfBirth;
    }

    public void setDateOfBirth(String DateOfBirth) {
        this.DateOfBirth = DateOfBirth;
    }

    public boolean isGender() {
        return Gender;
    }

    public void setGender(boolean Gender) {
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

    public String getUserRole() {
        return UserRole;
    }

    public void setUserRole(String UserRole) {
        this.UserRole = UserRole;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public String getCreateAt() {
        return CreateAt;
    }

    public void setCreateAt(String CreateAt) {
        this.CreateAt = CreateAt;
    }

    @Override
    public String toString() {
        return "Users{" + "UserID=" + UserID + ", Username=" + Username + ", Password=" + Password + ", Email=" + Email + ", FirstName=" + FirstName + ", LastName=" + LastName + ", Address=" + Address + ", DateOfBirth=" + DateOfBirth + ", Gender=" + Gender + ", PhoneNumber=" + PhoneNumber + ", Image=" + Image + ", UserRole=" + UserRole + ", Status=" + Status + ", CreateAt=" + CreateAt + '}';
    }

  
  

      
}
