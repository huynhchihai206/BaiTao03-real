<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${product.productname}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">ShopHai</a>
        <div class="navbar-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/product">Sản phẩm</a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product">Sản phẩm</a></li>
            <li class="breadcrumb-item active">${product.productname}</li>
        </ol>
    </nav>

    <div class="card shadow-sm">
        <div class="row g-0">
            <div class="col-md-5">
                <c:choose>
                    <c:when test="${product.images != null && product.images.substring(0,5)=='https'}">
                        <c:url value="${product.images}" var="imgUrl"/>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${product.images}" var="imgUrl"/>
                    </c:otherwise>
                </c:choose>
                <img src="${imgUrl}" class="img-fluid rounded-start" style="width:100%;height:100%;object-fit:cover;">
            </div>
            <div class="col-md-7">
                <div class="card-body">
                    <h3 class="card-title">${product.productname}</h3>
                    <span class="badge bg-secondary mb-3">${product.category.categoryname}</span>
                    <h4 class="text-danger fw-bold mb-3">
                        <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> đ
                    </h4>
                    <h6>Mô tả</h6>
                    <p class="text-muted">${product.description}</p>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-primary mt-2">&larr; Quay lại danh sách</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
