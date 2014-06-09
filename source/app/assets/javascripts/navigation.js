$(document).ready(function(){
    $(this).on('click', '.sign-in', function(e){
        $('li.sign-in').fadeOut(500);
        $('.sign-in-form').stop(true, true)
                            .animate({
                            height:"toggle",
                            opacity:"toggle"
                            },1000);
    });

    $('h1#logo').hover(function(){
        console.log('hovering');
        $('h1 a').css("color", "yellow");
        $('h1 a span').css("color", "white");
    }, function(){
        $('h1 a').css("color", "white");
        $('h1 a span').css("color", "yellow");
    });
});