//= require i18n
//= require i18n.js
//= require i18n/translations
//= require jquery3
//= require sb-admin-2
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on(`turbolinks:load`, function () {
  $(`#notification`).fadeOut(5000);
});
