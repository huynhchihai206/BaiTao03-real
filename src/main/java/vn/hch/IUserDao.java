package vn.hch;

public interface IUserDao {
    User findById(String username);
    void update(User user);
    void insert(User user);
}