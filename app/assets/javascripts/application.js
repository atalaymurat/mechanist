//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require popper
//= require bootstrap
//= require activestorage
//= require nested_form_fields
//= require dynamic_selectable
//= require pagy
//= require jquery.easy-autocomplete
//= require selectize
//= require turbolinks
//= require chosen
//= require_tree .

window.addEventListener("turbolinks:load", Pagy.init);

function chosen_init() {
    $(".chosen-select").chosen().change();
}
$(document).on('turbolinks:load', function(){chosen_init()});
