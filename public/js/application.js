$(document).ready(function() {

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
  })
})

});
