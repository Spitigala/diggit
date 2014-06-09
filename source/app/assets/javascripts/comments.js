$(document).ready(function() {
    $('.new_comment').submit(function(e) {
        e.preventDefault();
        var comment = $('input[id=comment_content]').val()
        var songID = $('input[id=comment_song_id').val()
        $.ajax({
            url: "/songs/" + songID + "/comments",
            type: "POST",
            data: {
                comment: {
                    content: comment
                }
            },
            dataType: "json"
        }).done(function(response) {

            var comment = '<li class="hidden">' + response.content + '<br>'
            comment += '<span class="vote-total">[ 0 ]</span>'
            // comment += '<div class="vote-links">'
            comment += ' Posted By: <a href="/users/' + response.user_id + '">' + response.username + '</a></li>'

            $('.comment-list ul').prepend(comment);
            $('.comment-list ul li:first-child').slideDown(500);
        }, "json" )
    })









});