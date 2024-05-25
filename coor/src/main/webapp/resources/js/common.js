$(document).ready(function(){

	/*헤더 스크롤*/
	 $(window).scroll(function(){
	    let h=$(window).scrollTop();
	    if (h > 10){
	        $("#header").addClass("on");
	        $(".header_logo").addClass("on");
	    }else{
	        $("#header").removeClass("on");
	        $(".header_logo").removeClass("on");
	    }
	});
	$(window).trigger('scroll'); 

	
	
	/*gnb 메뉴*/
	let menu = $(".menu > li.op")
	let submenu = $("div.sub-menu > ul > li")


	menu.on("mouseover", function(){
	    if (menu.hasClass("on") == false){

	        $(this).find("div.sub-menu").stop().fadeIn(300);
	    }
    });
	
	menu.on("mouseout", function(){
        $(this).find("div.sub-menu").stop().fadeOut(200);
    })
    
	
	submenu.on("mouseover", function(){
	    if (submenu.hasClass("on") == false){

	        $(this).find("ul.sub-cate").stop().fadeIn(300);
	        $("div.sub-menu li a").removeClass("on");
	        $(this).children().addClass("on");
	    }
    });
	
	submenu.on("mouseout", function(){
        $(this).find("ul.sub-cate").stop().fadeOut(200);
        $("div.sub-menu li a").removeClass("on");
	})
    
	
	
}); 


