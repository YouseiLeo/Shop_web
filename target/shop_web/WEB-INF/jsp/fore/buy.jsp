<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<%@include file="../include/admin/adminHeader.jsp"%>
<%@include file="../include/fore/top_nosearch.jsp"%>


<div class="buyPageDiv">
    <form action="forecreateOrder" method="post">

        <div class="buyFlow">
            <div style="clear:both"></div>
        </div>
        <div class="address">
            <div class="addressTip">输入收货地址</div>
            <div>
                <table class="addressTable">
                    <tr>
                        <td class="firstColumn">详细地址<span class="redStar">*</span></td>

                        <td><textarea name="address" placeholder="请填写详细收货地址"></textarea></td>
                    </tr>
<%--                    <tr>--%>
<%--                        <td>邮政编码</td>--%>
<%--                        <td><input  name="post"  type="text"></td>--%>
<%--                    </tr>--%>
                    <tr>
                        <td>收货人姓名<span class="redStar">*</span></td>
                        <td><input  name="receiver" type="text"></td>
                    </tr>
                    <tr>
                        <td>手机号码 <span class="redStar">*</span></td>
                        <td><input name="mobile"  placeholder="请输入11位手机号码" type="text"></td>
                    </tr>
                    <br/>
                    <tr>
                        <td>用户留言 </td>
                        <td><textarea name="message"></textarea></td>
                    </tr>
                </table>

            </div>

        </div>
        <div class="productList">
            <div class="productListTip">确认订单信息</div>

            <table class="productListTable">
                <thead>
                <tr>
                    <th colspan="2" class="productListTableFirstColumn"></th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                    <th>配送方式</th>
                </tr>
                <tr class="rowborder">
                    <td  colspan="2" ></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </thead>
                <tbody class="productListTableTbody">
                <c:forEach items="${orderItems}" var="oi" varStatus="st" >
                    <tr class="orderItemTR">
                        <td class="orderItemFirstTD"><img class="orderItemImg" src="../images/productSingle/${oi.product.image}.jpg"></td>
                        <td class="orderItemProductInfo">
                            <a  href="foreproduct?pid=${oi.product.id}" class="orderItemProductLink">
                                    ${oi.product.name}
                            </a>
                        </td>
                        <td>
                            <span class="orderItemProductPrice">￥<fmt:formatNumber type="number" value="${oi.price}" minFractionDigits="2"/></span>
                        </td>
                        <td>
                            <span class="orderItemProductNumber">${oi.number}</span>
                        </td>
                        <td><span class="orderItemUnitSum">
						￥<fmt:formatNumber type="number" value="${oi.number*oi.price}" minFractionDigits="2"/>
						</span></td>
                        <c:if test="${st.count==1}">
                            <td rowspan="5"  class="orderItemLastTD">
                                <label class="orderItemDeliveryLabel">
                                    普通配送
                                </label>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>

                </tbody>

            </table>
            <div class="orderItemSumDiv">
                <span class="pull-right">合计(含运费): ￥<fmt:formatNumber type="number" value="${totalPrice}" minFractionDigits="2"/></span>
            </div>

        </div>

        <div class="orderItemTotalSumDiv">
            <div class="pull-right">
                <span>实付款：</span>
                <span class="orderItemTotalSumSpan">￥<fmt:formatNumber type="number" value="${totalPrice}" minFractionDigits="2"/></span>
            </div>
        </div>

        <div class="submitOrderDiv">
            <button type="submit" class="submitOrderButton">提交订单</button>
        </div>
    </form>
</div>