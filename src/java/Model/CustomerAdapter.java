package Model;

import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * Adapter class để tương thích Customer với Users model hiện tại
 * @author lenovo
 */
public class CustomerAdapter extends Users {
    
    public CustomerAdapter(Customer customer) {
        super();
        if (customer != null) {
            this.UserID = customer.getCustomerID();
            this.Username = customer.getUsername();
            this.Password = customer.getPassword();
            this.Email = customer.getEmail();
            this.FirstName = customer.getFirstName();
            this.LastName = customer.getLastName();
            this.Address = customer.getAddress();
            this.DateOfBirth = customer.getDateOfBirth() != null ? customer.getDateOfBirth().toString() : null;
            this.Gender = customer.getGender() != null ? customer.getGender() : false;
            this.PhoneNumber = customer.getPhoneNumber();
            this.Image = customer.getImage();
            this.UserRole = "Customer"; // Mặc định là Customer
            this.Status = customer.getStatus();
            this.CreateAt = customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : null;
        }
    }
    
    public static Customer toCustomer(Users user) {
        if (user == null) return null;
        
        Customer customer = new Customer();
        customer.setCustomerID(user.getUserID());
        customer.setUsername(user.getUsername());
        customer.setPassword(user.getPassword());
        customer.setEmail(user.getEmail());
        customer.setFirstName(user.getFirstName());
        customer.setLastName(user.getLastName());
        customer.setAddress(user.getAddress());
        
        // Parse DateOfBirth
        if (user.getDateOfBirth() != null && !user.getDateOfBirth().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                customer.setDateOfBirth(sdf.parse(user.getDateOfBirth()));
            } catch (Exception e) {
                customer.setDateOfBirth(null);
            }
        }
        
        customer.setGender(user.isGender());
        customer.setPhoneNumber(user.getPhoneNumber());
        customer.setImage(user.getImage());
        customer.setStatus(user.getStatus());
        
        // Parse CreateAt
        if (user.getCreateAt() != null && !user.getCreateAt().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                customer.setCreatedAt(sdf.parse(user.getCreateAt()));
            } catch (Exception e) {
                customer.setCreatedAt(null);
            }
        }
        
        return customer;
    }
}
