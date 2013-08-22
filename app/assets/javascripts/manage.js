$(document).ready(function() 
{
  //click on app, generates a form

  $('tr').click(function(e)
{
    var name = $(this).children().eq(0).text();
    var description = $(this).children().eq(1).text();
    var url = $(this).children().eq(2).text();
    var id = $(this).attr('id');
    $('#app-name').val(name);
    $('#app-description').val(description);
    $('#app-url').val(url);
    $('#app-id').val(id);
  });


  //click submit on the form, sends the data to server, reloads index
  $('#appSubmit').click(function(e)
{
    var name = $('#app-name').val();
    var description = $('#app-description').val();
    var url = $('#app-url').val();
    var assign_id = $('#app-id').val();

     var pobj = {name: name, description: description, url: url, assign_id: assign_id}; 

      $.ajax({
          type: "POST",
          url: "/application_assignments/create_or_update",
          data: JSON.stringify(pobj),
          dataType: "json",
         contentType: "application/json"
     });

        
  });


//        alert($('#myField').val());
        /*
        $.post('http://path/to/post', 
           $('#myForm').serialize(), 
           function(data, status, xhr){
             // do something here with response;
           });
        */


/*
      $.ajax({
          type: "POST",
          url: "/application_assignments/drag_update",
          data: JSON.stringify(pobj),
         complete: function(){
          $('.ui-tooltip').remove();
          },
          dataType: "json",
         contentType: "application/json"
     });
*/

});
