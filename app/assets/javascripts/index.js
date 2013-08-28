$(window).load(function() 
{

  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span class="content"><img src="{{image}}"><a href="{{ url }}"><h4>{{ name }}</h4></span><span class="link"></span></a></li>');
  var bookmarkTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span class="content"><img src="{{image}}"><a href="{{ url }}"><h4>{{ name }}</h4></span><span class="link"></span></a><span class="editor"><input class="editor-name" id="appendedInput" value="{{ name }}" type="text"><input class="editor-description" id="appendedInput" value="{{ description }}" type="text"><input class="editor-url" id="appendedInput" value="{{ url }}" type="text"><button class="editor-save btn btn-success btn-mini"><i class="icon-white icon-ok"></i> Save</button></span></li>');


  //fill out applications
  for(var i = 0; i < DssPortal.apps.length;i++)
  {
    if((DssPortal.apps[i].bookmark) == true)
    {
      	  $('#sortableApp').append(bookmarkTemplate(DssPortal.apps[i]));
    }
    else
    {
	    $('#sortableApp').append(appTemplate(DssPortal.apps[i]));

    }
  }

  //fill out favorites
  for(var i = 0; i < DssPortal.favorites.length;i++)
  {
    if((DssPortal.favorites[i].bookmark) == true)
    {
       $('#sortableApp').append(bookmarkTemplate(DssPortal.favorites[i]));
    }
    else
    {
	    $('#sortableFav').append(appTemplate(DssPortal.favorites[i]));	
    }
  }

   //applies styled tooltips on application cards
   $('li').tooltip();

  //processing user input
  $("#sortableFav, #sortableApp" ).sortable({
	distance: 15,
  delay: 300,
	placeholder: "target",
	forcePlaceholderSize: true,
  zIndex: 10000, //or greater than any other relative/absolute/fixed elements and droppables
  stop: function(event, ui) 
  {
    SendState();
  },
  connectWith: ".connectedSortable"
	});
  
  //ON HOVER - apply dropshadow, make relevant UI elemnts appear
  $('li').hover
  (
     function()
    { 
      $(this).addClass('hover-card');
//      $(this).find("button").css({visibility: 'visible'});
    },
     function()
    { 
      $(this).removeClass('hover-card'); 
//      $(this).find("button").css({visibility: 'hidden'});
    }
  ) 

  //ON DRAG 
  $('#sortableApp li, #sortableFav li').mousedown(function() {
      $(this).removeClass('hover-card'); 
      $(this).addClass('dragging-card');
  });

  $('li').mouseup(function() 
  {
     $(this).removeClass('dragging-card');
     $(this).removeClass('hover-card');

  });

  $('.editor-toggle').click(function()
  { $(".editor").toggle();
        $(".content").toggle();
/*
    $('.card').each(function()
    {
      if($(this).find('.editor').length != 0) 
      {
        $(".editor").toggle();
        $(".content").toggle();
        $('.link').toggle();
        $(this).toggleClass('active');
      
        if($('.card').tooltip('option', 'disabled'))
        {
          $('.card').tooltip('option', {'disabled' : false});
        }    
        else
        {
          $('.card').tooltip('option', {'disabled' : true});
        }
      }

    });
*/
  });

  $('.editor-save').click(function()
  {
    var id = $(this).parent().parent().attr('id');
    var name = $(this).parent().children('.editor-name').val();
    var description = $(this).parent().children('.editor-description').val();
    var url = $(this).parent().children('.editor-url').val();
    var application_assignment = {name: name, description: description, url: url};
    var data = {id: id, application_assignment: application_assignment};
/*    $.ajax({
      type: "PUT",
      url: "/application_assignments/987",
      data: JSON.stringify(data),
      dataType: "json",
     contentType: "application/json"
    });
*/
    $(this).parent().parent().children('a').attr('href', url);
    $(this).parent().parent().attr('title', description);
    $(this).parent().parent().find('h4').text(name);
        
   });

});

function SendState()
{
  var pageLayout = [];
  var appStructure;
  var i = 1;
  $("#sortableFav li").each(function() {      
    var id = $(this).attr('id');
    appStructure = {position: i, app_id: id, favorite: "true"};      
    i++;    
    pageLayout.push(appStructure); 
  });

  i = 1;
  
  $("#sortableApp li").each(function() { 
    var id = $(this).attr('id');
    appStructure = {position: i, app_id: id, favorite: "false"};      
    i++;    
    pageLayout.push(appStructure); 
  });
  var pobj = {pageLayout: pageLayout}; 

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
}
