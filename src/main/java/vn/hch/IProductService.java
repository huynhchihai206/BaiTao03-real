package vn.hch;

import java.util.List;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int productId);
    Product findById(int productId);
    List<Product> findAll();
    List<Product> findLatest(int limit);
    List<Product> findAll(int page, int pagesize);
    int count();
    int countTotalPages(int pagesize);
}
