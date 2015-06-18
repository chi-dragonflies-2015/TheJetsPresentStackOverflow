$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

    $('html').on('click', '.upvote',function(event){
      event.preventDefault();
      var url = $(this).attr('href');
      var request = $.ajax({
                url: url,
                method: 'get'
        });
      request.done(function(response){
              $('#' + response.id + ' .vote_tally').text(response.tally);
  console.log(response.tally);
      });
  });
    $('html').on('click', '.downvote',function(event){
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
