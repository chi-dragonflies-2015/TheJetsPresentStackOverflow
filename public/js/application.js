$(document).ready(function() {

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

  // Function to Display New Answer Form and Hide New Answer Button
   $('.new-answer').on("click", function(event) {
    event.preventDefault();
    $(this).hide();
    $('#create-answer').show();

   });


  // Function to send Ajax on New Answer form submission
  $('#create-answer').on("submit", function(event) {
    event.preventDefault();
     var data = $(this).serialize();
     var url = $(this).attr('action');
     var request = $.ajax({
                            url: url,
                            method: "post",
                            data: data

  });

     var response = request.done(function(formData){
      $('.answers').append(formData);
      $('#create-answer').hide();
      $('.new-answer').show();

     });


  });
  //Function to send Ajax on edit answer form submission
  $('.answers').on("click",'.edit-button',function(event) {
    event.preventDefault();
    $('.edit-answer').show();
    $('.edit-button').hide();

  });

  //Function to edit answer form and populate question
  $('.answers').on("submit","#edit-answer", function(event){
    event.preventDefault();

    var data =$(this).serialize();
    var url = $(this).attr('action');
    var answer_id = $(this).parents('.answer').attr('id')
    var request = $.ajax ({
                          url: url,
                          data: data,
                          method: "put"
  });
    var response = request.done(function(response){

  $('#' + answer_id + ' .answer-header h1').text(response.title);
  $('#' + answer_id + ' .answer-content p').text(response.content);
      // $(startingForm).parent()
      // $('answer-content').text(response.title);
      // $()
      // $('answer-content').text(response.content);

      // $('.edit-answer').hide();
    })
  });
  $('.answers').on('submit', '#delete-answer', function(event){
    event.preventDefault();
    var delete_link = this;
    var url = $(this).attr('action');
    var answer_id = $(this).parents('.answer').attr('id')
    var request = $.ajax({
                    url: url,
                    method: 'delete'
    });

    var response = request.done(function(data){
      $('#' + answer_id ).remove();
    });
  });
});
