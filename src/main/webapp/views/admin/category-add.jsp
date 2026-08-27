<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<form action="<c:url value='/admin/category/insert'/>" method="post" enctype="multipart/form-data">
    <label>Category name:</label><br>
    <input type="text" name="categoryname"><br>
    <label>Link images:</label><br>
    <input type="text" name="images"><br>
    <label>Upload images:</label><br>
    <input type="file" name="images1"><br>
    <label>Status</label><br>
    <input type="radio" name="status" value="1" checked>
    <label>Hoạt động</label><br>
    <input type="radio" name="status" value="0">
    <label>Khóa</label><br><br>
    <input type="submit" value="Insert">
</form>