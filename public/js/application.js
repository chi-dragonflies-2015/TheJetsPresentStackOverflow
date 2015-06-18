$(document).ready(function() {
    $('html').on('click','.upvote',function(event){
      event.preventDefault();
      var url = $(this).attr('href');
      var request = $.ajax({
                url: url,
                method: 'get'
        });
      request.done(function(response){
              $('#' + response.id + ' .vote_tally').text(response.tally);
      });
    });

    $('html').on('click','.downvote',function(event){
      event.preventDefault();
      var url = $(this).attr('href');
      var request = $.ajax({
                url: url,
                method: 'get'
        });
      request.done(function(response){
              $('#' + response.id + ' .vote_tally').text(response.tally);
      });
  });
});
