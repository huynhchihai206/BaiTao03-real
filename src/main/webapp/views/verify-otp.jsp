<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Xác thực OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { min-height:100vh; display:flex; align-items:center;
               background:linear-gradient(135deg,#6a11cb 0%,#2575fc 100%); }
        .auth-card { max-width:420px; width:100%; }
        .otp-input { letter-spacing:.5rem; text-align:center; font-size:1.4rem; }
    </style>
</head>
<body>
<div class="container">
    <div class="auth-card mx-auto">
        <div class="card border-0 shadow-lg">
            <div class="card-body p-4 p-md-5">
                <h3 class="text-center fw-bold mb-1">Xác thực OTP</h3>
                <p class="text-center text-muted mb-4">Mã OTP đã gửi tới <b>${email}</b></p>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                    <input type="hidden" name="email" value="${email}">
                    <div class="mb-4">
                        <label class="form-label">Mã OTP</label>
                        <input type="text" name="otp" class="form-control form-control-lg otp-input" maxlength="6" required autofocus>
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">Xác thực</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
