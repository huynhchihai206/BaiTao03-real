package vn.hch;

public interface IUserDao {
    User findById(String username);
    User findByEmail(String email);
    void update(User user);
    void insert(User user);
}