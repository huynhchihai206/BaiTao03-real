<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { min-height:100vh; display:flex; align-items:center;
               background:linear-gradient(135deg,#6a11cb 0%,#2575fc 100%); }
        .auth-card { max-width:420px; width:100%; }
    </style>
</head>
<body>
<div class="container">
    <div class="auth-card mx-auto">
        <div class="card border-0 shadow-lg">
            <div class="card-body p-4 p-md-5">
                <h3 class="text-center fw-bold mb-4">Đăng nhập</h3>
                <c:if test="${not empty message}">
                    <div class="alert alert-success py-2">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label class="form-label">Tên đăng nhập</label>
                        <input type="text" name="username" class="form-control form-control-lg" value="${username}" required autofocus>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu</label>
                        <input type="password" name="password" class="form-control form-control-lg" required>
                    </div>
                    <div class="text-end mb-3">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none">Quên mật khẩu?</a>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">Đăng nhập</button>
                    </div>
                </form>
                <p class="text-center text-muted mt-4 mb-0">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-semibold">Đăng ký ngay</a>
                </p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
