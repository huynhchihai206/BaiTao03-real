<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Chỉnh sửa Profile</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:wght@600;700&display=swap"
                rel="stylesheet">
            <style>
                :root {
                    --ink: #1d2939;
                    --muted: #667085;
                    --line: #e4e7ec;
                    --paper: #ffffff;
                    --wash: #f4f7f8;
                    --teal: #087f8c;
                    --teal-dark: #075e68;
                    --gold: #e0a458;
                }

                * {
                    box-sizing: border-box;
                }

                body {
                    margin: 0;
                    color: var(--ink);
                    background: var(--wash);
                    font-family: "DM Sans", sans-serif;
                }

                .topbar {
                    background: #172b3a;
                    color: #fff;
                    padding: 18px 0;
                }

                .topbar-inner,
                .page {
                    width: min(1100px, calc(100% - 32px));
                    margin: 0 auto;
                }

                .topbar-inner {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    gap: 20px;
                }

                .brand {
                    color: #fff;
                    font-family: "Playfair Display", serif;
                    font-size: 24px;
                    text-decoration: none;
                }

                .nav-links {
                    display: flex;
                    align-items: center;
                    gap: 22px;
                }

                .nav-links a {
                    color: #d7e2e8;
                    text-decoration: none;
                    font-size: 14px;
                }

                .nav-links a:hover {
                    color: #fff;
                }

                .logout {
                    border: 1px solid #8ca3ad;
                    border-radius: 6px;
                    padding: 8px 13px;
                }

                .page {
                    padding: 46px 0 64px;
                }

                .eyebrow {
                    color: var(--teal);
                    font-size: 12px;
                    font-weight: 700;
                    letter-spacing: .14em;
                    text-transform: uppercase;
                }

                h1 {
                    font-family: "Playfair Display", serif;
                    font-size: clamp(30px, 5vw, 44px);
                    margin: 8px 0 10px;
                }

                .intro {
                    color: var(--muted);
                    margin: 0 0 28px;
                }

                .profile-grid {
                    display: grid;
                    grid-template-columns: 280px 1fr;
                    gap: 24px;
                    align-items: start;
                }

                .panel {
                    background: var(--paper);
                    border: 1px solid var(--line);
                    border-radius: 8px;
                    box-shadow: 0 12px 30px rgba(23, 43, 58, .07);
                }

                .identity {
                    padding: 28px;
                    text-align: center;
                }

                .avatar {
                    width: 116px;
                    height: 116px;
                    margin: 0 auto 18px;
                    border-radius: 50%;
                    object-fit: cover;
                    border: 5px solid #e5f3f3;
                }

                .avatar-placeholder {
                    display: grid;
                    place-items: center;
                    background: #d8eeee;
                    color: var(--teal-dark);
                    font-size: 42px;
                    font-weight: 700;
                }

                .identity h2 {
                    font-size: 19px;
                    margin: 0 0 5px;
                }

                .identity p {
                    color: var(--muted);
                    font-size: 14px;
                    margin: 0;
                }

                .identity-line {
                    height: 1px;
                    background: var(--line);
                    margin: 24px 0;
                }

                .identity-note {
                    color: var(--muted);
                    font-size: 13px;
                    line-height: 1.6;
                }

                .form-panel {
                    padding: 32px;
                }

                .form-heading {
                    display: flex;
                    justify-content: space-between;
                    align-items: baseline;
                    gap: 16px;
                    margin-bottom: 24px;
                }

                .form-heading h2 {
                    font-size: 21px;
                    margin: 0;
                }

                .required {
                    color: var(--muted);
                    font-size: 12px;
                }

                .alert {
                    border-radius: 6px;
                    padding: 12px 14px;
                    margin-bottom: 20px;
                    font-size: 14px;
                }

                .alert-success {
                    color: #176b43;
                    background: #e7f6ee;
                    border: 1px solid #b9e5cc;
                }

                .alert-danger {
                    color: #a33131;
                    background: #fff0f0;
                    border: 1px solid #f2c1c1;
                }

                .field-grid {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 20px;
                }

                .field {
                    margin-bottom: 20px;
                }

                label {
                    display: block;
                    font-size: 13px;
                    font-weight: 700;
                    margin-bottom: 8px;
                }

                input[type="text"],
                input[type="tel"],
                input[type="file"] {
                    width: 100%;
                    border: 1px solid #cfd6dd;
                    border-radius: 5px;
                    padding: 12px 13px;
                    color: var(--ink);
                    background: #fff;
                    font: inherit;
                }

                input:focus {
                    outline: 3px solid rgba(8, 127, 140, .14);
                    border-color: var(--teal);
                }

                input[readonly] {
                    color: #667085;
                    background: #f2f4f7;
                }

                .help {
                    color: var(--muted);
                    font-size: 12px;
                    margin-top: 7px;
                }

                .actions {
                    display: flex;
                    align-items: center;
                    gap: 14px;
                    margin-top: 8px;
                    padding-top: 24px;
                    border-top: 1px solid var(--line);
                }

                .button {
                    border: 0;
                    border-radius: 5px;
                    padding: 12px 20px;
                    cursor: pointer;
                    font: inherit;
                    font-weight: 700;
                }

                .button-primary {
                    color: #fff;
                    background: var(--teal);
                }

                .button-primary:hover {
                    background: var(--teal-dark);
                }

                .button-link {
                    color: var(--muted);
                    text-decoration: none;
                    font-size: 14px;
                }

                @media (max-width: 720px) {
                    .topbar-inner {
                        align-items: flex-start;
                        flex-direction: column;
                    }

                    .nav-links {
                        flex-wrap: wrap;
                        gap: 12px 18px;
                    }

                    .page {
                        padding-top: 32px;
                    }

                    .profile-grid,
                    .field-grid {
                        grid-template-columns: 1fr;
                    }

                    .identity,
                    .form-panel {
                        padding: 24px;
                    }
                }
            </style>
        </head>

        <body>
            <header class="topbar">
                <div class="topbar-inner">
                    <a class="brand" href="${pageContext.request.contextPath}/home">ShopHai</a>
                    <nav class="nav-links" aria-label="Điều hướng chính">
                        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                        <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
                        <a href="${pageContext.request.contextPath}/profile">Profile</a>
                        <a class="logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                    </nav>
                </div>
            </header>

            <main class="page">
                <div class="eyebrow">Tài khoản cá nhân</div>
                <h1>Chỉnh sửa thông tin</h1>
                <p class="intro">Cập nhật thông tin để tài khoản của bạn luôn chính xác.</p>

                <div class="profile-grid">
                    <aside class="panel identity">
                        <c:choose>
                            <c:when test="${not empty user.images && user.images.substring(0, 4) == 'http'}">
                                <img class="avatar" src="${user.images}" alt="Ảnh đại diện của ${user.fullname}">
                            </c:when>
                            <c:when test="${not empty user.images}">
                                <img class="avatar" src="${pageContext.request.contextPath}/image?fname=${user.images}"
                                    alt="Ảnh đại diện của ${user.fullname}">
                            </c:when>
                            <c:otherwise>
                                <div class="avatar avatar-placeholder">${user.fullname.substring(0, 1)}</div>
                            </c:otherwise>
                        </c:choose>
                        <h2>${user.fullname}</h2>
                        <p>@${user.username}</p>
                        <div class="identity-line"></div>
                        <p class="identity-note">Ảnh đại diện giúp tài khoản của bạn dễ nhận biết hơn.</p>
                    </aside>

                    <section class="panel form-panel">
                        <div class="form-heading">
                            <h2>Thông tin tài khoản</h2>
                            <span class="required">* Bắt buộc</span>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/profile" method="post"
                            enctype="multipart/form-data">
                            <div class="field-grid">
                                <div class="field">
                                    <label for="username">Tài khoản (Username)</label>
                                    <input id="username" type="text" name="username" value="${user.username}" readonly>
                                </div>
                                <div class="field">
                                    <label for="fullname">Họ và tên *</label>
                                    <input id="fullname" type="text" name="fullname" value="${user.fullname}"
                                        minlength="2" maxlength="255" required>
                                </div>
                            </div>

                            <div class="field">
                                <label for="phone">Số điện thoại *</label>
                                <input id="phone" type="tel" name="phone" value="${user.phone}" pattern="0[0-9]{9,10}"
                                    maxlength="11" required>
                                <div class="help">Nhập số điện thoại gồm 10 hoặc 11 chữ số, bắt đầu bằng số 0.
                                </div>
                            </div>

                            <div class="field">
                                <label for="imageFile">Ảnh đại diện mới</label>
                                <input id="imageFile" type="file" name="imageFile"
                                    accept="image/jpeg,image/png,image/gif,image/webp">
                                <div class="help">Định dạng hỗ trợ: JPG, PNG, GIF hoặc WEBP.</div>
                            </div>

                            <div class="actions">
                                <button class="button button-primary" type="submit">Lưu thay đổi</button>
                                <a class="button-link" href="${pageContext.request.contextPath}/home">Hủy</a>
                            </div>
                        </form>
                    </section>
                </div>
            </main>
        </body>

        </html>