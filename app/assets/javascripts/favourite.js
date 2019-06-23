$(document).on('turbolinks:load', function () {
  $(document).on('click', '#add_favourite', function () {
    var favourableId = $('#favourability').siblings('#favourable_id').val();
    var favourableType = $('#favourability').siblings('#favourable_type').val();

    $.ajax({
      url: '/favourites',
      type: 'POST',
      data: {
        'favourite[favourable_id]': favourableId,
        'favourite[favourable_type]': favourableType
      }
    });

    $(this).children('i').toggleClass('fa-heart-o fa-heart');
    $(this).attr('id', 'remove_favourite');

    Swal.fire({
      title: I18n.t(`swal.success.favourite_added`),
      type: `success`, showCancelButton: false,
      confirmButtonText: I18n.t(`swal.ok`)
    })
  });

  $(document).on('click', '#remove_favourite', function () {
    var favourableId = $('#favourability').siblings('#favourable_id').val();
    var favourableType = $('#favourability').siblings('#favourable_type').val();

    $.ajax({
      url: '/favourites',
      type: 'DELETE',
      data: {
        'favourite[favourable_id]': favourableId,
        'favourite[favourable_type]': favourableType
      }
    });

    $(this).children('i').toggleClass('fa-heart-o fa-heart');
    $(this).attr('id', 'add_favourite');

    Swal.fire({
      title: I18n.t(`swal.success.favourite_removed`),
      type: `success`, showCancelButton: false,
      confirmButtonText: I18n.t(`swal.ok`)
    })
  });
});
