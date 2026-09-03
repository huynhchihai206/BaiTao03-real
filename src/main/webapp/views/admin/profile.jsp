<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa Profile</title>
</head>
<body>
    <div class="container mt-4">
        <h3>CẬP NHẬT THÔNG TIN CÁ NHÂN</h3>
        <hr/>
        
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label">Tài khoản (Username):</label>
                <input type="text" class="form-control" name="username" value="${user.username}" readonly />
            </div>

            <div class="mb-3">
                <label class="form-label">Họ và tên:</label>
                <input type="text" class="form-control" name="fullname" value="${user.fullname}" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Số điện thoại:</label>
                <input type="text" class="form-control" name="phone" value="${user.phone}" required />
            </div>

            <div class="mb-3">
                <label class="form-label">Ảnh đại diện:</label><br/>
                <c:if test="${not empty user.images}">
                    <c:choose>
                        <c:when test="${user.images.substring(0, 4) == 'http'}">
                            <img src="${user.images}" width="150" height="150" class="rounded mb-2" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/image?fname=${user.images}" width="150" height="150" class="rounded mb-2" />
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <input type="file" class="form-control mt-2" name="imageFile" accept="image/*" />
            </div>

            <button type="submit" class="btn btn-success">Cập nhật</button>
        </form>
    </div>
</body>
</html>