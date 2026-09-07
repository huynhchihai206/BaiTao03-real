<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Sửa danh mục</title>
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
                <h1 class="admin-title">Sửa danh mục</h1>
                <p class="admin-subtitle">Cập nhật tên, trạng thái hoặc ảnh danh mục.</p>
                <section class="admin-panel admin-form-panel">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="categoryid" value="${cate.categoryId}">
                        <div class="admin-field"><label>Tên danh mục</label><input type="text" name="categoryname"
                                value="${cate.categoryname}" required maxlength="255"></div>
                        <div class="admin-field"><label>Link ảnh</label><input type="text" name="images"
                                value="${cate.images}"></div>

                        <c:if test="${cate.images != null && cate.images.substring(0,5)=='https'}">
                            <c:url value="${cate.images }" var="imgUrl"></c:url>
                        </c:if>
                        <c:if test="${cate.images != null && cate.images.substring(0,5)!='https'}">
                            <c:url value="/image?fname=${cate.images }" var="imgUrl"></c:url>
                        </c:if>
                        <img class="admin-preview" src="${imgUrl}" alt="${cate.categoryname}"><br>

                        <div class="admin-field"><label>Upload ảnh mới</label><input type="file" name="images1"
                                accept="image/jpeg,image/png,image/gif,image/webp"></div>
                        <div class="admin-field"><label>Trạng thái</label><label><input type="radio" name="status"
                                    value="1" ${cate.status==1?'checked':'' }> Hoạt động</label><label><input
                                    type="radio" name="status" value="0" ${cate.status!=1?'checked':'' }> Khóa</label>
                        </div>
                        <button class="admin-btn admin-btn-primary" type="submit">Lưu thay đổi</button>
                        <a href="<c:url value='/admin/categories'/>" class="admin-btn admin-btn-light">Hủy</a>
                    </form>
                </section>
            </main>
        </body>

        </html>