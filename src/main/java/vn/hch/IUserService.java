package vn.hch;

public interface IUserService {
    User findById(String username);
    User findByEmail(String email);
    void update(User user);
    void insert(User user);

    void register(String username, String email, String password, String fullname) throws Exception;
    boolean verifyOtp(String email, String otp);
    User login(String username, String password) throws Exception;
    void requestPasswordReset(String email) throws Exception;
    boolean resetPassword(String email, String otp, String newPassword);
}