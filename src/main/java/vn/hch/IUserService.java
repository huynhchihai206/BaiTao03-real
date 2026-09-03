package vn.hch;

public interface IUserService {
    User findById(String username);
    void update(User user);
    void insert(User user);
}