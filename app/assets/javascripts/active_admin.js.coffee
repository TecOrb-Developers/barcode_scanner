#= require active_admin/base

$(document).ready ->
  $(document).on 'change', '#list_product', ->
    value = $(this).val()
    $.ajax
      type: "GET"
      url: "/product_ingredient_list"
      data: product_id: value
      dataType: "json"
      success: (data) ->  
        html = ""
        $.each data.product_ingredient, (i, value) ->
          html += "<option value=" + value.id + ">" + value.ingredient_name + "</option>"
          return
        $("#list_ingredient").html html
    return
  return
return