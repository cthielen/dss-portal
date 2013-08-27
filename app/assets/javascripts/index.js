$(window).load(function() 
{

  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span class="content"><img src="{{image}}"></i><a title="Launch Website" href="{{ url }}"><h4>{{ name }}</h4></span><span class="link"></span></a><span class="editor"><input class="editor-name" id="appendedInput" value="{{ name }}" type="text"><input class="editor-description" id="appendedInput" value="{{ description }}" type="text"><span class="input-append"><span class="add-on">http</span><input class="editor-url" id="appendedInput" value="{{ url }}" type="text"></span></span></li>');
  var favoriteTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span class="content"><img src="{{image}}"></i><a title="Launch Website" href="{{ url }}"><h4>{{ name }}</h4></span><span class="link"></span></a><span class="editor"><input class="editor-name" id="appendedInput" value="{{ name }}" type="text"><input class="editor-description" id="appendedInput" value="{{ description }}" type="text"><span class="input-append"><span class="add-on">http</span><input class="editor-url" id="appendedInput" value="{{ url }}" type="text"></span></span></li>');


  //fill out applications
  for(var i = 0; i < DssPortal.apps.length;i++)
  {
	  $('#sortableApp').append(appTemplate(DssPortal.apps[i]));	
  }

  //fill out favorites
  for(var i = 0; i < DssPortal.favorites.length;i++)
  {
	  $('#sortableFav').append(favoriteTemplate(DssPortal.favorites[i]));	
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
  {  
    $(".editor").toggle();
    $(".content").toggle();
    $('.link').toggle();

    if($('.card').tooltip('option', 'disabled'))
    {
      $('.card').tooltip('option', {'disabled' : false});
    }    
    else
    {
      $('.card').tooltip('option', {'disabled' : true});
    }
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
