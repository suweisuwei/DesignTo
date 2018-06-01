/**
 * 整体页面相关 JS
 */
/**
 * 动态调整页脚的位置，页面短就放在浏览器底部，页面长就放在内容底部。
 */
function justifyFooter(){
    var footer = $("#footer");
    var dist = $("#footer")[0].offsetTop;
    var h = window.innerHeight;
    // if(dist < h+200){
    //     footer.css("position","fixed");
    //     footer.css("bottom","0");
    // }else{
        footer.css("position","relative");
        footer.css("bottom","");
    // }
}
//点赞 AJAX，
// 要求：
// 包裹的框有属性：data-pid=[pid]，
// 按钮包括2个子元素：span：图形，label：文字。
// 点赞数文字包裹在 class="like-count"元素内。
function like(uid, pid) {
    $.get(
        "/like",
        {uid: uid, pid: pid},
        function (data) {
            if (data == 'true') {
                var count = $('[data-pid=' + pid + '] .like-count');
                var btn = $('[data-pid=' + pid + '] button')
                var num = parseInt(count.text());
                count.text(num + 1);
                btn.children("span").addClass("liked");
                btn.children("label").text("已赞");
                btn.attr("disabled", "disabled");
            }
        }
    );
}





$(function(){
    justifyFooter();
});