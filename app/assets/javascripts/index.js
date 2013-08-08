$(window).load(function() 
{


var taco = _.size({one : 1, two : 2, three : 3});

 _.templateSettings = 
  { 
    interpolate : /\{\{(.+?)\}\}/g
  };
  var favoriteTemplate = _.template(' <li class="favorite" id="{{id}}">{{ name }}</li>');

  for(var i = 0; i < DssPortal.apps.length;i++)
  {
	  $('#sortable').append(favoriteTemplate(DssPortal.apps[i]));	
  }

alert("Hi");

 var txt1="<li>HAHAHA</li>";  
  $("#sortable").append(txt1);

  $( "#sortable" ).sortable({
	distance: 15,
	placeholder: "highlight",
	forcePlaceholderSize: true,
    stop: function(event, ui) 
	  {
      
	  }
	}).disableSelection();

});
