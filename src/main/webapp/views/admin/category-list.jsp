<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Quản lý danh mục</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        </head>

        <body class="admin-page">
            <header class="admin-topbar">
                <div class="admin-topbar-inner">
                    <a class="admin-brand" href="${pageContext.request.contextPath}/home">ShopHai</a>
                    <nav class="admin-nav">
                        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                        <a href="${pageContext.request.contextPath}/admin/categories">Danh mục</a>
                        <a href="${pageContext.request.contextPath}/admin/products">Sản phẩm</a>
                        <a href="${pageContext.request.contextPath}/profile">Profile</a>
                        <a class="admin-logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </nav>
                </div>
            </header>
            <main class="admin-main">
                <div class="admin-kicker">Khu vực quản trị</div>
                <div class="admin-title-row">
                    <div>
                        <h1 class="admin-title">Danh mục</h1>
                        <p class="admin-subtitle">Phân loại sản phẩm để cửa hàng dễ quản lý.</p>
                    </div>
                    <a href="<c:url value='/admin/category/add'/>" class="admin-btn admin-btn-primary">+ Thêm danh
                        mục</a>
                </div>
                <section class="admin-panel admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Ảnh</th>
                                <th>Tên danh mục</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listcate}" var="cate" varStatus="STT">
                                <tr>
                                    <td class="admin-muted">${STT.index + 1}</td>
                                    <c:choose>
                                        <c:when test="${cate.images != null && cate.images.substring(0,5)=='https'}">
                                            <c:url value="${cate.images}" var="imgUrl" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${cate.images}" var="imgUrl" />
                                        </c:otherwise>
                                    </c:choose>
                                    <td><img class="admin-thumb" src="${imgUrl}" alt="${cate.categoryname}"></td>
                                    <td><strong>${cate.categoryname}</strong></td>
                                    <td><span
                                            class="admin-status ${cate.status == 1 ? 'admin-status-active' : 'admin-status-locked'}">${cate.status
                                            == 1 ? 'Hoạt động' : 'Khóa'}</span></td>
                                    <td>
                                        <div class="admin-actions">
                                            <a href="<c:url value='/admin/category/edit?id=${cate.categoryId}'/>"
                                                class="admin-btn admin-btn-light">Sửa</a>
                                            <a href="<c:url value='/admin/category/delete?id=${cate.categoryId}'/>"
                                                class="admin-btn admin-btn-danger"
                                                onclick="return confirm('Xác nhận xóa danh mục này?')">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listcate}">
                                <tr>
                                    <td colspan="5" class="admin-empty">Chưa có danh mục nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </section>
            </main>
        </body>

        </html>