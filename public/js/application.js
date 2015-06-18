$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  function commentButtons (commentId) {
    return ' <a class="comment-edit" href="#edit">Edit</a><form class="comment-delete" action="/comments/'+commentId+'/delete" method="post"><input type="hidden" name="_method" value="delete"><input type="submit" value="Delete"></form>'
  };

  $('.comment-form').on('submit', function(event){
    event.preventDefault();

    var url = $(this).attr('action');
    var data = $(this).serialize();

    var request = $.ajax({
              url: url,
              method: 'POST',
              data: data
    });

    request.done(function(response){
      $('.comments ul').append(
        $('<li id='+response.id+'>' + response.content + commentButtons(response.id))
      );
      $('.comment-form textarea').val('');
    });
  });

  $('.comments').on('click', '.comment-edit', function(event){
    event.preventDefault();

    if ($('.comments').find('#dynaform').attr('action')){
      formText = $('#dynaform input[type=text]').val();
      id = $('#dynaform').parent().attr('id')

      $('#dynaform').replaceWith(formText + commentButtons(id));
    };

    $listItem = $(this).parent();
    commentId = $listItem.attr('id')
    commentText = $listItem
                    .clone()
                    .children()
                    .remove()
                    .end()
                    .text()
                    .trim();

    $listItem.html('<form id="dynaform" action="/comments/'+commentId+'/edit" method="post"><input type="hidden" name="_method" value="put" ><input name="content" type="text" value="'+commentText+'"><input type="submit"></form>');

    $listItem.on('submit', '#dynaform', function(event){
      event.preventDefault();

      id = $(this).parent().attr('id')

      url = $(this).attr('action');
      data = $(this).serialize();

      request = $.ajax({
              url: url,
              method: 'put',
              data: data
      });

      request.done(function(text){
        console.log(text);
        $listItem.html(text + commentButtons(id));
      });
    });
  });

  $('.comments').on('click', '.comment-delete', function(event){
    event.preventDefault();

    url = $(this).attr('action')

    request = $.ajax({
      url: url,
      method: 'delete'
    });

    request.done(function(id){
      $('.comments #'+id).remove();
    });
  });

});
