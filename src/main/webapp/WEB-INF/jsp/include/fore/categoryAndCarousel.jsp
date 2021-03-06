<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<div class="categoryWithCarousel">
    <div class="headbar show1">
        <div class="head" onclick="showcategoryMenu()">
            <span style="margin-left:50px" class="glyphicon glyphicon-th-list"></span>
            <span style="margin-left:50px" >商品分类</span>
        </div>
        <div class="rightMenu">
            <c:forEach items="${categories}" var="c" varStatus="st">
                <c:if test="${st.count<=5}">
				<span>
				<a href="forecategory?cid=${c.id}">
                        ${c.name}
                </a></span>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <div id = "categoryMenu" class="categoryMenu" style="margin-top: 37px;display: none">
        <c:forEach items="${categories}" var="c">
            <div cid="${c.id}" class="eachCategory">
                <span class="glyphicon glyphicon-link"></span>
                <a href="forecategory?cid=${c.id}">
                        ${c.name}
                </a>
            </div>
        </c:forEach>
    </div>
    <div class="carouselBackgroundDiv">
    </div>
</div>

<script type="text/javascript">
    function showcategoryMenu() {
        document.getElementById("categoryMenu").classList.toggle("show");
    }
    function showProductsAsideCategorys(cid){
        $("div.eachCategory[cid="+cid+"]").css("background-color","white");
        $("div.eachCategory[cid="+cid+"] a").css("color","#87CEFA");
        $("div.productsAsideCategorys[cid="+cid+"]").show();
    }
    function hideProductsAsideCategorys(cid){
        $("div.eachCategory[cid="+cid+"]").css("background-color","#e2e2e3");
        $("div.eachCategory[cid="+cid+"] a").css("color","#000");
        $("div.productsAsideCategorys[cid="+cid+"]").hide();
    }
    $(function(){
        $("div.eachCategory").mouseenter(function(){
            var cid = $(this).attr("cid");
            showProductsAsideCategorys(cid);
        });
        $("div.eachCategory").mouseleave(function(){
            var cid = $(this).attr("cid");
            hideProductsAsideCategorys(cid);
        });
        $("div.productsAsideCategorys").mouseenter(function(){
            var cid = $(this).attr("cid");
            showProductsAsideCategorys(cid);
        });
        $("div.productsAsideCategorys").mouseleave(function(){
            var cid = $(this).attr("cid");
            hideProductsAsideCategorys(cid);
        });

        $("div.rightMenu span").mouseenter(function(){
            var left = $(this).position().left;
            var top = $(this).position().top;
            var width = $(this).categoriess("width");
            var destLeft = parseInt(left) + parseInt(width)/2;
            $("img#catear").css("left",destLeft);
            $("img#catear").css("top",top-20);
            $("img#catear").fadeIn(500);

        });
        $("div.rightMenu span").mouseleave(function(){
            $("img#catear").hide();
        });

        var left = $("div#carousel-of-product").offset().left;
        $("div.categoryMenu").css("left",left-20);
        $("div.categoryWithCarousel div.head").css("margin-left",left);
        $("div.productsAsideCategorys").css("left",left-20);

    });
</script>