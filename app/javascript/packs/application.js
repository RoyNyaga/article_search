// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

require("bootstrap")
require("jquery")

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).on('turbolinks:load', function() {
  $("#query").on("keyup", function(){
    var action = $("#search-form").attr("action")
    var path = `${action}?query=${$(this).val()}`
    // $("#search-form").submit()
    console.log(path)
    $.get(path)
  })
})