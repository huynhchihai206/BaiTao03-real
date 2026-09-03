package vn.hch;

public class UserServiceImpl implements IUserService {
    private IUserDao userDao = new UserDao();

    @Override
    public User findById(String username) {
        return userDao.findById(username);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }
}