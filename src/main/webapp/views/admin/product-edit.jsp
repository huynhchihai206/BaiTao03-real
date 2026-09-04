<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Sửa sản phẩm</title>
<h3 class="mb-3">Sửa sản phẩm</h3>
<div class="card">
    <div class="card-body">
        <form action="<c:url value='/admin/product/update'/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.productId}">
            <div class="mb-3">
                <label class="form-label">Tên sản phẩm</label>
                <input type="text" name="productname" class="form-control" value="${product.productname}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giá</label>
                <input type="number" step="0.01" min="0" name="price" class="form-control" value="${product.price}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mô tả</label>
                <textarea name="description" class="form-control" rows="4">${product.description}</textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Danh mục</label>
                <select name="categoryId" class="form-select" required>
                    <c:forEach items="${listcate}" var="cate">
                        <option value="${cate.categoryId}" ${cate.categoryId == product.category.categoryId ? 'selected' : ''}>${cate.categoryname}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Ảnh hiện tại</label><br>
                <c:choose>
                    <c:when test="${product.images != null && product.images.substring(0,5)=='https'}">
                        <c:url value="${product.images}" var="imgUrl"/>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${product.images}" var="imgUrl"/>
                    </c:otherwise>
                </c:choose>
                <img src="${imgUrl}" style="width:100px;height:100px;object-fit:cover;" class="rounded border"/>
            </div>
            <div class="mb-3">
                <label class="form-label">Đổi link ảnh (https)</label>
                <input type="text" name="images" class="form-control" placeholder="https://...">
            </div>
            <div class="mb-3">
                <label class="form-label">Hoặc upload ảnh mới</label>
                <input type="file" name="images1" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">Cập nhật</button>
            <a href="<c:url value='/admin/products'/>" class="btn btn-outline-secondary">Hủy</a>
        </form>
    </div>
</div>
