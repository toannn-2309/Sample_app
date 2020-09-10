$(document).on('turbolinks:load', function() {
  $('#micropost_image').bind('change', function () {
    let size_in_megabytes = this.files[0].size / 1024 / 1024
    if (size_in_megabytes > 5) {
      alert(I18n.t("post.noti.size_fail_js"))
      $('#micropost_image').val("")
    }
  })
});
