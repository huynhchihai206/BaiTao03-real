<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">ShopHai</a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/product">Sản phẩm</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">Quản lý</a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <h3 class="mb-4">Tất cả sản phẩm</h3>
    <div class="row g-4">
        <c:forEach items="${products}" var="p">
            <div class="col-6 col-md-4">
                <a href="${pageContext.request.contextPath}/product-detail?id=${p.productId}" class="text-decoration-none text-dark">
                    <div class="card h-100 shadow-sm">
                        <c:choose>
                            <c:when test="${p.images != null && p.images.substring(0,5)=='https'}">
                                <c:url value="${p.images}" var="imgUrl"/>
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                            </c:otherwise>
                        </c:choose>
                        <img src="${imgUrl}" class="card-img-top" style="height:200px;object-fit:cover;">
                        <div class="card-body">
                            <h6 class="card-title text-truncate">${p.productname}</h6>
                            <p class="text-danger fw-bold mb-0">
                                <fmt:formatNumber value="${p.price}" type="number" maxFractionDigits="0"/> đ
                            </p>
                            <small class="text-muted">${p.category.categoryname}</small>
                        </div>
                    </div>
                </a>
            </div>
        </c:forEach>
        <c:if test="${empty products}">
            <p class="text-muted">Chưa có sản phẩm nào.</p>
        </c:if>
    </div>

    <c:if test="${totalPages > 1}">
        <nav class="mt-4">
            <ul class="pagination justify-content-center">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">&laquo;</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">&raquo;</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
</body>
</html>
