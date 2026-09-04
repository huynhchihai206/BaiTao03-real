<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<title>Quản lý sản phẩm</title>
<div class="d-flex justify-content-between align-items-center mb-3">
    <h3 class="mb-0">Danh sách sản phẩm</h3>
    <a href="<c:url value='/admin/product/add'/>" class="btn btn-success">+ Thêm sản phẩm</a>
</div>
<table class="table table-bordered table-hover align-middle">
    <thead class="table-dark">
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
                <td>${STT.index + 1}</td>
                <c:choose>
                    <c:when test="${p.images != null && p.images.substring(0,5)=='https'}">
                        <c:url value="${p.images}" var="imgUrl"/>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${p.images}" var="imgUrl"/>
                    </c:otherwise>
                </c:choose>
                <td><img src="${imgUrl}" style="width:80px;height:80px;object-fit:cover;" class="rounded"/></td>
                <td>${p.productname}</td>
                <td>${p.price}</td>
                <td>${p.category.categoryname}</td>
                <td>
                    <a href="<c:url value='/admin/product/edit?id=${p.productId}'/>" class="btn btn-sm btn-outline-primary">Sửa</a>
                    <a href="<c:url value='/admin/product/delete?id=${p.productId}'/>"
                       class="btn btn-sm btn-outline-danger"
                       onclick="return confirm('Xác nhận xóa?')">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty listproduct}">
            <tr><td colspan="6" class="text-center text-muted py-4">Chưa có sản phẩm nào</td></tr>
        </c:if>
    </tbody>
</table>
