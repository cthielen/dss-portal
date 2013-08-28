$(window).load(function() 
{

  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span><img src="{{image}}"><a href="{{ url }}"><h4>{{ name }}</h4></span><span class="link"></span></a></li>');
  var bookmarkTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><span class="content"><img src="{{image}}"><a href="{{ url }}"><h4>{{ name }}</h4><span class="link"></span></a></span><span class="edit-form"><input class="editor-name" value="{{ name }}" type="text"><input class="editor-description" value="{{ description }}" type="text"><input class="editor-url" value="{{ url }}" type="text"><button class="editor-save btn btn-success btn-mini"><i class="icon-white icon-ok"></i> Save</button></span></li>');


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
       $('#sortableFav').append(bookmarkTemplate(DssPortal.favorites[i]));
    }
    else
    {
	    $('#sortableFav').append(appTemplate(DssPortal.favorites[i]));	
    }
  }
  
  $('#sortableApp').append(' <li class="card" id="" title=""><span class="create-content"><button class="create-toggle btn btn-success btn-large"><i class="icon-white icon-plus"></i></button><h4>Create Application Bookmark</h4></span><span class="create-form"><input class="create-name" placeholder="Name" type="text"><input class="create-description" placeholder="Description" type="text"><input class="create-url" placeHolder="website URL" type="text"><button class="create btn btn-success btn-mini"><i class="icon-white icon-ok"></i> Create</button></span></li>');

   //applies styled tooltips on application cards
   $('li').tooltip();

  //processing user input
  $("#sortableFav, #sortableApp" ).sortable({
	distance: 15,
  delay: 300,
	placeholder: "target",
	forcePlaceholderSize: true,
  zIndex: 10000, //or greater than any other relative/absolute/fixed elements and droppables
  items: "li:not(:last-child)",
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
    $('.edit-form').toggle();
    $(this).toggleClass('active');
    $('.content').toggle();
    $('.content .link').toggle();     
    if($('.content').parent().tooltip('option', 'disabled'))
    {
      $('.content').parent().tooltip('option', {'disabled' : false});
    }    
    else
    {
      $('.card').tooltip('option', {'disabled' : true});
    }
  });

  $('.editor-save').click(function()
  {
    var id = $(this).parent().parent().attr('id');
    var name = $(this).parent().children('.editor-name').val();
    var description = $(this).parent().children('.editor-description').val();
    var url = $(this).parent().children('.editor-url').val();
    var application_assignment = {name: name, description: description, url: url};
    var data = {id: id, application_assignment: application_assignment};
    $.ajax({
      type: "PUT",
      url: "/application_assignments/" + id,
      data: JSON.stringify(data),
      dataType: "json",
     contentType: "application/json"
    });

    $(this).parent().parent().children('a').attr('href', url);
    $(this).parent().parent().attr('title', description);
    $(this).parent().parent().find('h4').text(name);
        
   });


  $('.create-toggle').click(function()
  {
      $('.create-content').toggle();
      $('.create-form').toggle();
  });

 $('.create').click(function()
  {
    var name = $(this).parent().children('.create-name').val();
    var description = $(this).parent().children('.create-description').val();
    var url = $(this).parent().children('.create-url').val();
    var application_assignment = {name: name, description: description, url: url};
    $.ajax({
      type: "POST",
      url: "/application_assignments/",
      data: JSON.stringify(application_assignment),
      dataType: "json",
     contentType: "application/json"
    });        

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
