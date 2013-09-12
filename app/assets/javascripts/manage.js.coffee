$(document).ready ->
  #click on app, generates a form
  $("tr").click (e) ->
    name = $(this).children().eq(0).text()
    description = $(this).children().eq(1).text()
    url = $(this).children().eq(2).text()
    id = $(this).attr("id")
    $("#app-name").val name
    $("#app-description").val description
    $("#app-url").val url
    $("#app-id").val id

  
  # Click submit on the form, sends the data to server, reloads index
  $("#appSubmit").click (e) ->
    name = $("#app-name").val()
    description = $("#app-description").val()
    url = $("#app-url").val()
    assign_id = $("#app-id").val()
    pobj =
      name: name
      description: description
      url: url
      assign_id: assign_id

    $.ajax
      type: "POST"
      url: "/application_assignments/create_or_update"
      data: JSON.stringify(pobj)
      dataType: "json"
      contentType: "application/json"
