package vn.hch;

import java.io.Serializable;
import java.time.LocalDateTime;
import jakarta.persistence.*;

@Entity
@Table(name = "users")
@NamedQuery(name = "User.findAll", query = "SELECT u FROM User u")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "username")
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "email", columnDefinition = "VARCHAR(255) NULL")
    private String email;

    @Column(name = "active")
    private boolean active;

    @Column(name = "otp", columnDefinition = "VARCHAR(10) NULL")
    private String otp;

    @Column(name = "otpExpiry")
    private LocalDateTime otpExpiry;

    @Column(name = "fullname", columnDefinition = "NVARCHAR(255) NULL")
    private String fullname;

    @Column(name = "phone", columnDefinition = "VARCHAR(20) NULL")
    private String phone;

    @Column(name = "images", columnDefinition = "NVARCHAR(500) NULL")
    private String images;

    public User() {}

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public String getOtp() { return otp; }
    public void setOtp(String otp) { this.otp = otp; }

    public LocalDateTime getOtpExpiry() { return otpExpiry; }
    public void setOtpExpiry(LocalDateTime otpExpiry) { this.otpExpiry = otpExpiry; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
}