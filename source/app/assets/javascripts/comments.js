$(document).ready(function(){
    $('.new_comment').submit(function(e){
      e.preventDefault();
      var comment = $('input[id=comment_content]').val()
      var songId = $('input[id=comment_song_id').val()
      $.ajax({
        url: "/songs/" + songID + "/comments",
        type: "POST",
        data: {comment: comment},
        dataType: json
      }).done(function(response) {
        console.log(response)
      })
    })











});
