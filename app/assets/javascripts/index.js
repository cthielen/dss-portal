$(window).load(function() 
{
  //Drawing Content to page
  _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };

  var appTemplate = _.template(' <li class="card" id="{{id}}" title="TEST description HERE"><img src="http://i.imgur.com/ss8rqyg.jpg"><a href ="{{ url }}"><h4>{{ name }}</h4></a><img class="move-icon" src="http://i.imgur.com/qEshcfP.png"></li>');
  var favoriteTemplate = _.template(' <li class="card" id="{{id}}" title="{{ description }}"><img src="http://i.imgur.com/IOmyrAV.jpg"><a href ="{{ url }}"><h4>{{ name }}</h4></a><img class="move-icon" src="http://i.imgur.com/qEshcfP.png"></li>');

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
	placeholder: "target",
	forcePlaceholderSize: true,
  zIndex: 10000, //or greater than any other relative/absolute/fixed elements and droppables
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
         complete: function(){
          $('.ui-tooltip').remove();
          },
          dataType: "json",
         contentType: "application/json"
     });
	  },
connectWith: ".connectedSortable"
	});
  
  //applies styled tooltips on application cards
  $(function() 
  {
    $('li').tooltip();
  });
  
  //ON HOVER - apply dropshadow, make relevant UI elemnts appear
$('li').hover
(
       function(){ $(this).addClass('hover-card') },
       function(){ $(this).removeClass('hover-card') }
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
//   $(this).css({'zIndex' : 10});
});



//  $(this).append("<img class='move-icon' src='http://i.imgur.com/qEshcfP.png'>")
//  }, function(){

//  $(this).children(".move-icon").remove();
//  })

});
