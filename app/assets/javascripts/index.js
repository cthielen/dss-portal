$(window).load(function() 
{
  alert("index.js LAUNCHED");

  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="application" id="{{id}}">{{ name }}</li>');
  var favoriteTemplate = _.template(' <li class="favorite" id="{{id}}">{{ name }}</li>');

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
  $( "#sortable" ).sortable({
	distance: 15,
	placeholder: "highlight",
	forcePlaceholderSize: true,
    stop: function(event, ui) 
	  {
      
	  }
	}).disableSelection();

});
