<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Thêm danh mục</title>
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
                <h1 class="admin-title">Thêm danh mục</h1>
                <p class="admin-subtitle">Tạo nhóm mới để phân loại sản phẩm.</p>
                <section class="admin-panel admin-form-panel">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
                        <div class="admin-field"><label>Tên danh mục</label><input type="text" name="categoryname"
                                required maxlength="255"></div>
                        <div class="admin-field"><label>Link ảnh</label><input type="text" name="images"
                                placeholder="https://..."></div>
                        <div class="admin-field"><label>Upload ảnh</label><input type="file" name="images1"
                                accept="image/jpeg,image/png,image/gif,image/webp"></div>
                        <div class="admin-field"><label>Trạng thái</label><label><input type="radio" name="status"
                                    value="1" checked> Hoạt động</label><label><input type="radio" name="status"
                                    value="0"> Khóa</label></div>
                        <button class="admin-btn admin-btn-primary" type="submit">Lưu danh mục</button>
                        <a href="<c:url value='/admin/categories'/>" class="admin-btn admin-btn-light">Hủy</a>
                    </form>
                </section>
            </main>
        </body>

        </html>