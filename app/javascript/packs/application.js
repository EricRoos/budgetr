// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

window.jQuery = $;
window.$ = $;
import {Turbo, cable} from "@hotwired/turbo-rails"
require("@rails/activestorage").start()
require("channels")

require("bootstrap")

// stylesheets
require("../stylesheets/main.scss")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")

const ujs = require("@rails/ujs");
window.ujs = ujs;
window.ujs.start()

window.Turbo = Turbo;

$('.toast').toast({delay: 1500})
$(document).ready(function(){
  $(".modal").on('shown.bs.modal', function () {
    $(this).find("input:visible").first().focus();
  });

  $(".modal").on('hide.bs.modal', function () {
    const template = $(this).find("template[data-loader]")[0]
    if(template){
      const loadingContent = template.content.cloneNode(true);
      console.log(loadingContent);
      const modalDialog = $(this).find(".modal-dialog")[0];
      modalDialog.innerHTML = '';
      modalDialog.appendChild(loadingContent);
    }
  });
  $("#editItemModal").on('hide.bs.modal', function () {
    ujs.ajax({ type: 'POST', url: '/clear_locks' })
  });
});



import "controllers"
