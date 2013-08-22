$(window).load(function() 
{

  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><img src="{{image}}"><button class="card-interface-favorite" title="Add to Favorites"><i class="icon-heart icon-white"></i></button><button class="card-interface-left"><i class="icon-arrow-left"></i></button><button class="card-interface-right"><i class="icon-arrow-right"></i></button><button class="card-interface-edit" title="Edit Bookmark"><i class="icon-edit"></i></button><a title="Launch Website" href ="{{ url }}"><h4>{{ name }}</h4></a></li>');
  var favoriteTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><img src="{{image}}"><button class="card-interface-favorite" title="Add to Favorites"><i class="icon-heart icon-white"></i></button><button class="card-interface-left"><i class="icon-arrow-left"></i></button><button class="card-interface-right"><i class="icon-arrow-right"></i></button><button class="card-interface-edit" title="Edit Bookmark"><i class="icon-edit"></i></button><a title="Launch Website" href="{{ url }}"><h4>{{ name }}</h4></a></li>');

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
  $('li').mousedown(function() {
      $(this).removeClass('hover-card'); 
      $(this).addClass('dragging-card');
  });

  $('li').mouseup(function() 
  {
     $(this).removeClass('dragging-card');
     $(this).removeClass('hover-card');

  });

/*  $('.card-interface-left').click(function() 
  { 
    var elementToBeMoved = $(this).parent();
    $(elementToBeMoved).insertBefore($(elementToBeMoved).prev());
    SendState();
  });

  $('.card-interface-right').click(function() 
  { 
    var elementToBeMoved = $(this).parent();
    $(elementToBeMoved).insertAfter($(elementToBeMoved).next());
    SendState();
  });

  $('.card-interface-favorite').click(function() 
  { 
    var elementToBeMoved = $(this).parent();
    if(elementToBeMoved.parent().attr('id') == 'sortableApp')
      $('#sortableFav').append(elementToBeMoved);
    else
      $('#sortableApp').append(elementToBeMoved);
    SendState();

  });
*/
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
