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
    if(dist < h){
        footer.css("position","fixed");
        footer.css("bottom","0");
    }else{
        footer.css("position","relative");
        footer.css("bottom","");
    }
}






$(function(){
    justifyFooter();
});