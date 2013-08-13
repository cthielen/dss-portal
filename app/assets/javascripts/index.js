$(window).load(function() 
{
  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="drag" id="{{id}}" title="{{ description }}"><a href ="{{ url }}">{{ name }}</a></li>');
  var favoriteTemplate = _.template(' <li class="drag" id="{{id}}">{{ name }}</li>');

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

        //if its different, build an array of hashes  id/fav/position and send to rails
      var pageLayout = []
      var appLayout;
      var i = 1;
      $("#sortableFav li").each(function() { 
        appStructure = {position: i, id: $this.attr('id'), favorite: "true"};      
        i++;    
        appLayout.push(appStructure); 
      });

      i = 0;
      
      $("#sortableApp li").each(function() { 
        appStructure = {position: i, id: $this.attr('id'), favorite: "false"};      
        i++;    
        appLayout.push(appStructure); 
      });

//        $.post("/favorites/drag_create", pobj, function(data) {
//				$("#" + data.old_id).attr('id', data.new_id);
//			});
	  },
connectWith: ".connectedSortable"
	});

});
