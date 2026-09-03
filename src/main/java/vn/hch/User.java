package vn.hch;

import java.io.Serializable;
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

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getImages() { return images; }
    public void setImages(String images) { this.images = images; }
}