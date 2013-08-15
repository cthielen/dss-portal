$(window).load(function() 
{
  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="drag" id="{{id}}" title="{{ description }}"><a href ="{{ url }}"><h4>{{ name }}</h4></a><img src="http://i.imgur.com/IOmyrAV.jpg"></li>');
  var favoriteTemplate = _.template(' <li class="drag" id="{{id}}"><a href ="{{ url }}"><h4>{{ name }}</h4></a><img src="http://i.imgur.com/IOmyrAV.jpg"></li>');

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

  //processing user input
  $("#sortableFav, #sortableApp" ).sortable({
	distance: 15,
	placeholder: "highlight",
	forcePlaceholderSize: true,
    stop: function(event, ui) 
	  {
     //check DSSportal.app and DSSportal.fav against their current states to verify a change occured
     
     //if an app was toggled favorite/unfavorite, change its display icon
    
      //if a change was detected, build an array of hashes  id/fav/position and send to rails
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
         success: function(){},
          dataType: "json",
         contentType: "application/json"
     });
	  },
connectWith: ".connectedSortable"
	});

});
