<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<form action="<c:url value='/admin/category/update'/>" method="post" enctype="multipart/form-data">
    <input type="hidden" name="categoryid" value="${cate.categoryId}">
    <label>Category name:</label><br>
    <input type="text" name="categoryname" value="${cate.categoryname}"><br>
    <label>Link images:</label><br>
    <input type="text" name="images" value="${cate.images}"><br>
    
    <c:if test="${cate.images != null && cate.images.substring(0,5)=='https'}">
        <c:url value="${cate.images }" var="imgUrl"></c:url>
    </c:if>
    <c:if test="${cate.images != null && cate.images.substring(0,5)!='https'}">
        <c:url value="/image?fname=${cate.images }" var="imgUrl"></c:url>
    </c:if>
    <img height="150" width="200" src="${imgUrl}" /><br>
    
    <label>Upload images:</label><br>
    <input type="file" name="images1"><br>
    <label>Status</label><br>
    <input type="radio" name="status" value="1" ${cate.status==1?'checked':'' }>
    <label>Hoạt động</label><br>
    <input type="radio" name="status" value="0" ${cate.status!=1?'checked':'' }>
    <label>Khóa</label><br><br>
    <input type="submit" value="Update">
</form>