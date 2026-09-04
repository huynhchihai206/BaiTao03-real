<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Thêm sản phẩm</title>
<h3 class="mb-3">Thêm sản phẩm mới</h3>
<div class="card">
    <div class="card-body">
        <form action="<c:url value='/admin/product/insert'/>" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label">Tên sản phẩm</label>
                <input type="text" name="productname" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" step="0.01" min="0" name="price" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mô tả</label>
                <textarea name="description" class="form-control" rows="4"></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Danh mục</label>
                <select name="categoryId" class="form-select" required>
                    <c:forEach items="${listcate}" var="cate">
                        <option value="${cate.categoryId}">${cate.categoryname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Link ảnh (https)</label>
                <input type="text" name="images" class="form-control" placeholder="https://...">
            </div>
            <div class="mb-3">
                <label class="form-label">Hoặc upload ảnh</label>
                <input type="file" name="images1" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">Lưu</button>
            <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">Hủy</a>
        </form>
    </div>
</div>
