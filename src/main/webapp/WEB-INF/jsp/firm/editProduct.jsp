<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>

<% String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../include/admin/adminHeader.jsp"%>

<div class="workingArea">
    <ol class="breadcrumb">
        <li><a href="category_list">所有分类</a></li>
        <li><a href="product_list?cid=${c.id}">${c.name}</a></li>
        <li class="active">${p.name}</li>
    </ol>
    <div class="panel panel-warning editDiv">
        <div class="panel-heading">编辑产品</div>
        <div class="panel-body">
            <form method="post" id="editForm" action="<%=basePath%>/firm/product_update">
                <table class="editTable">
                    <tr>
                        <td>产品名称</td>
                        <td><input id="name" name="name" value="${p.name}"
                                   type="text" style="width:300px;" class="form-control"></td>
                    </tr>
                    <tr>
                        <td>原价格</td>
                        <td><input id="original_price" value="${p.original_price}" name="original_price" type="text"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td>优惠价格</td>
                        <td><input id="now_price"  value="${p.now_price}" name="now_price" type="text"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td>库存</td>
                        <td><input id="stock_number"  value="${p.stock_number}" name="stock_number" type="text"
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td>详细信息</td>
                        <td><input id="message"  value="${p.message}" name="message" type="text"
                                   class="form-control"></td>
                    </tr>
                    <br/>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" name="id" value="${p.id}">
                            <input type="hidden" name="cid" value="${p.cid}">
                            <button type="submit" class="btn btn-success">提 交</button></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script>
    $(function() {
        $("#editForm").submit(function() {
            if (!checkEmpty("name", "产品名称"))
                return false;
            if (!checkNumber("original_price", "原价格"))
                return false;
            if (!checkNumber("now_price", "优惠价格"))
                return false;
            if (!checkInt("stock_number", "库存"))
                return false;
            var stock_number =  document.getElementById("stock_number").value;
            if(parseInt(stock_number)<0){
                alert("库存不能为负数");
                return false;
            }
            var msg = "确认修改吗?\n请确认！";
            if (confirm(msg)==true){
                return true;
            }else{
                return false;
            }
            return true;
        });
    });
</script>