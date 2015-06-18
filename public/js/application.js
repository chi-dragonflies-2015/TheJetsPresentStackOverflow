$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
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
        $('<li id='+response.id+'>' + response.content + " <a class='comment-edit' href='#edit'>Edit</a> <a class='comment-delete' href='#delete'>Delete</a>" + '</li>')
      )
    });
  });

  $('.comments').on('click', '.comment-edit', function(event){
    event.preventDefault();

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

      url = $(this).attr('action');
      data = $(this).serialize();

      response = $.ajax({
              url: url,
              method: 'put',
              data: data
      });

      response.done(function(text){
        console.log(text);
        $listItem.html(text + " <a class='comment-edit' href='#edit'>Edit</a> <a class='comment-delete' href='#delete'>Delete</a>");
      });
    });
  });
});
