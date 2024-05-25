$(document).ready(function(){

    $('.slide-wrap').slick({
		slidesToShow: 1,
		infinite: true,
		draggable:true,
		cssEase: 'linear',
        autoplaySpeed: 2000,
		arrow: true,
        prevArrow : $('.slide-prev'),
        nextArrow : $('.slide-next'),
    });


}); 