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

$(document).on('turbolinks:load', function () {
  $('#notification').fadeOut(5000);

  $(document).on('click', '.small_track', function() {
    var audio = $(this).children('audio');
    var image = $(this).children('#cover').html();
    var track_year = $(this).find('#year').html();
    var track_artist = $(this).find('#artist').html();
    var track_title = $(this).find('#title').html();

    $('#now_playing').find('#cover').html(image);
    $('#now_playing').find('#cover img').removeClass('d-none');
    $('#now_playing').find('#year').html(track_year);
    $('#now_playing').find('#artist').html(track_artist);
    $('#now_playing').find('#title').html(track_title);

    $('#audio_player')[0].src = audio[0].src;
    $('#audio_player')[0].load();
    $('#audio_player')[0].play();
  });
});
