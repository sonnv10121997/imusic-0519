//= require i18n
//= require i18n.js
//= require i18n/translations
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery.raty
//= require ratyrate
//= require sb-admin-2
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
    var track_id = $(this).attr('value');

    $('#now_playing').find('#cover').html(image);
    $('#now_playing').find('#cover img').removeClass('d-none');
    $('#now_playing').find('#year').html(track_year);
    $('#now_playing').find('#artist').html(track_artist);
    $('#now_playing').find('#title').html(track_title);

    $('#audio_player').siblings('#track_id').val(track_id);
    $('#audio_player')[0].src = audio[0].src;
    $('#audio_player')[0].load();
    $('#audio_player')[0].play();
  });

  $('#audio_player').on('play', function() {
    var trackId = $(this).siblings('#track_id').val();
    var albumId = $(this).siblings('#album_id').val();

    $.ajax({
      url: '/play',
      type: 'POST',
      data: {
        'hit[track_id]': trackId,
        'hit[album_id]': albumId
      }
    });
  });
});
