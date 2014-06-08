$(document).ready(function(){
    $(this).on('click', '.sign-in', function(e){
        $('li.sign-in').fadeOut(500);
        $('.sign-in-form').stop(true, true)
                            .animate({
                            height:"toggle",
                            opacity:"toggle"
                            },1000);
    });
});