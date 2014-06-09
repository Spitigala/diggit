$(document).ready(function(){
    $('.new_comment').submit(function(e){
      e.preventDefault();
      var comment = $('input[id=comment_content]').val()
      var songID = $('input[id=comment_song_id').val()
      $.ajax({
        url: "/songs/" + songID + "/comments",
        type: "POST",
        data: {comment: {content: comment}},
        dataType: "json"
      }).done(function(response) {
        console.log(response);
        var comment = '<li>Comment: ' + response.content + '<br>'
        comment += 'Posted By: <a href="/users/' + response.user_id + '">' + response.username + '</a></li>'
        $('ul').append(comment);
      })
    })











});
