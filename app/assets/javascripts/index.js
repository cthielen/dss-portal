$(window).load(function() 
{
  
 alert("hi!");

	$( "#sortableFav, #sortableApp" ).sortable({
	delay: 300,
	distance: 15,
	placeholder: "highlight",
	forcePlaceholderSize: true,
  //event stuff here
	connectWith: ".connectedSortable"
	}).disableSelection();
});
