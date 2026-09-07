package vn.hch;

import java.time.LocalDateTime;

public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDao();

    @Override
    public User findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public void register(String username, String email, String password, String fullname) throws Exception {
        if (userDao.findById(username) != null) {
            throw new Exception("Tên đăng nhập đã tồn tại");
        }
        if (userDao.findByEmail(email) != null) {
            throw new Exception("Email đã được đăng ký");
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(PasswordUtil.hash(password));
        user.setFullname(fullname);
        user.setActive(true);
        userDao.insert(user);
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }
        if (user.getOtp() == null || !user.getOtp().equals(otp)) {
            return false;
        }
        if (user.getOtpExpiry() == null || user.getOtpExpiry().isBefore(LocalDateTime.now())) {
            return false;
        }

        user.setActive(true);
        user.setOtp(null);
        user.setOtpExpiry(null);
        userDao.update(user);
        return true;
    }

    @Override
    public User login(String username, String password) throws Exception {
        User user = userDao.findById(username);
        if (user == null) {
            throw new Exception("Tên đăng nhập không tồn tại");
        }
        if (!user.isActive()) {
            throw new Exception("Tài khoản chưa được kích hoạt");
        }
        if (!PasswordUtil.matches(password, user.getPassword())) {
            throw new Exception("Mật khẩu không đúng");
        }
        return user;
    }

    @Override
    public void requestPasswordReset(String email) throws Exception {
        User user = userDao.findByEmail(email);
        if (user == null) {
            throw new Exception("Email không tồn tại");
        }

        String otp = OtpUtil.generateOtp();
        user.setOtp(otp);
        user.setOtpExpiry(LocalDateTime.now().plusMinutes(5));
        userDao.update(user);

        String content = "<p>Xin chào " + user.getFullname() + ",</p>"
                + "<p>Mã OTP để đặt lại mật khẩu của bạn là: <b>" + otp + "</b></p>"
                + "<p>Mã có hiệu lực trong 5 phút. Nếu bạn không yêu cầu, hãy bỏ qua email này.</p>";
        MailUtil.sendMail(email, "Dat lai mat khau", content);
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        User user = userDao.findByEmail(email);
        if (user == null) {
            return false;
        }
        if (user.getOtp() == null || !user.getOtp().equals(otp)) {
            return false;
        }
        if (user.getOtpExpiry() == null || user.getOtpExpiry().isBefore(LocalDateTime.now())) {
            return false;
        }

        user.setPassword(PasswordUtil.hash(newPassword));
        user.setOtp(null);
        user.setOtpExpiry(null);
        userDao.update(user);
        return true;
    }
}
