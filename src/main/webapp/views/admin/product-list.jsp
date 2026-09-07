<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Quản lý sản phẩm</title>
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
                        <h1 class="admin-title">Sản phẩm</h1>
                        <p class="admin-subtitle">Quản lý kho sản phẩm và thông tin hiển thị.</p>
                    </div>
                    <a href="<c:url value='/admin/product/add'/>" class="admin-btn admin-btn-primary">+ Thêm sản
                        phẩm</a>
                </div>
                <section class="admin-panel admin-table-wrap">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Danh mục</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listproduct}" var="p" varStatus="STT">
                                <tr>
                                    <td class="admin-muted">${STT.index + 1}</td>
                                    <c:choose>
                                        <c:when test="${p.images != null && p.images.substring(0,5)=='https'}">
                                            <c:url value="${p.images}" var="imgUrl" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:url value="/image?fname=${p.images}" var="imgUrl" />
                                        </c:otherwise>
                                    </c:choose>
                                    <td><img class="admin-thumb" src="${imgUrl}" alt="${p.productname}"></td>
                                    <td><strong>${p.productname}</strong></td>
                                    <td>${p.price}</td>
                                    <td>${p.category.categoryname}</td>
                                    <td>
                                        <div class="admin-actions">
                                            <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>"
                                                class="admin-btn admin-btn-light">Sửa</a>
                                            <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>"
                                                class="admin-btn admin-btn-danger"
                                                onclick="return confirm('Xác nhận xóa sản phẩm này?')">Xóa</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty listproduct}">
                                <tr>
                                    <td colspan="6" class="admin-empty">Chưa có sản phẩm nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </section>
            </main>
        </body>

        </html>