<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Sửa sản phẩm</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        </head>

        <body class="admin-page">
            <header class="admin-topbar">
                <div class="admin-topbar-inner"><a class="admin-brand"
                        href="${pageContext.request.contextPath}/home">ShopHai</a>
                    <nav class="admin-nav"><a href="${pageContext.request.contextPath}/home">Trang chủ</a><a
                            href="${pageContext.request.contextPath}/admin/categories">Danh mục</a><a
                            href="${pageContext.request.contextPath}/admin/products">Sản phẩm</a><a
                            href="${pageContext.request.contextPath}/profile">Profile</a><a class="admin-logout"
                            href="${pageContext.request.contextPath}/logout">Đăng xuất</a></nav>
                </div>
            </header>
            <main class="admin-main">
                <div class="admin-kicker">Khu vực quản trị</div>
                <h1 class="admin-title">Sửa sản phẩm</h1>
                <p class="admin-subtitle">Cập nhật thông tin và hình ảnh sản phẩm.</p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <h3 class="mb-3">Sửa sản phẩm</h3>
                <div class="card">
                    <div class="admin-form-panel">
                        <form action="<c:url value='/admin/product/update'/>" method="post"
                            enctype="multipart/form-data">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <div class="admin-field">
                                <label class="form-label">Tên sản phẩm</label>
                                <input type="text" name="productname" class="form-control"
                                    value="${product.productname}" maxlength="255" required>
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Giá</label>
                                <input type="number" step="0.01" min="0" name="price" class="form-control"
                                    value="${product.price}" required>
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Mô tả</label>
                                <textarea name="description" class="form-control"
                                    rows="4">${product.description}</textarea>
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Danh mục</label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach items="${listcate}" var="cate">
                                        <option value="${cate.categoryId}"
                                            ${cate.categoryId==product.category.categoryId ? 'selected' : '' }>
                                            ${cate.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Ảnh hiện tại</label><br>
                                <c:choose>
                                    <c:when test="${product.images != null && product.images.substring(0,5)=='https'}">
                                        <c:url value="${product.images}" var="imgUrl" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:url value="/image?fname=${product.images}" var="imgUrl" />
                                    </c:otherwise>
                                </c:choose>
                                <img src="${imgUrl}" class="admin-preview" />
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Đổi link ảnh (https)</label>
                                <input type="text" name="images" class="form-control" placeholder="https://...">
                            </div>
                            <div class="admin-field">
                                <label class="form-label">Hoặc upload ảnh mới</label>
                                <input type="file" name="images1" class="form-control"
                                    accept="image/jpeg,image/png,image/gif,image/webp">
                            </div>
                            <button type="submit" class="admin-btn admin-btn-primary">Lưu thay đổi</button>
                            <a href="<c:url value='/admin/products'/>" class="admin-btn admin-btn-light">Hủy</a>
                        </form>
                    </div>
                </div>
            </main>
        </body>

        </html>