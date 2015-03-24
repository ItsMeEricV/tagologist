// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

console.log('tag_map');

$( document ).ready(function() {
  $('.tag_name').click(function(e) {
    tag = $(e.currentTarget).data('tag');
    $('*[data-tag-name="' + tag + '"]').addClass('code');
  });
});