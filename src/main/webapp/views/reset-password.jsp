<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { min-height:100vh; display:flex; align-items:center;
               background:linear-gradient(135deg,#6a11cb 0%,#2575fc 100%); }
        .auth-card { max-width:420px; width:100%; }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="auth-card mx-auto">
        <div class="card border-0 shadow-lg">
            <div class="card-body p-4 p-md-5">
                <h3 class="text-center fw-bold mb-1">Đặt lại mật khẩu</h3>
                <p class="text-center text-muted mb-4">Nhập mã OTP và mật khẩu mới cho <b>${email}</b></p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/reset-password" method="post">
                    <input type="hidden" name="email" value="${email}">
                    <div class="mb-3">
                        <label class="form-label">Mã OTP</label>
                        <input type="text" name="otp" class="form-control form-control-lg" maxlength="6" required autofocus>
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="password" name="newPassword" class="form-control form-control-lg" required>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">Đặt lại mật khẩu</button>
                    </div>
                </form>
                <p class="text-center mt-4 mb-0">
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">&larr; Quay lại đăng nhập</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
