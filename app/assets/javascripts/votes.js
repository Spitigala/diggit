$(document).ready(function(){
    $('.vote-links a').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        var self = this;
        $.post($(this).attr('href')).done(function(response){
            $(self).parent().prev().html("[ " + response.voteTotal + " ]");
        });
    });
});