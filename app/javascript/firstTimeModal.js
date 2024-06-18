document.addEventListener('DOMContentLoaded', function() {
  var firstTimeModal = new bootstrap.Modal(document.getElementById('firstTimeModal'), {
    keyboard: false
  });
  firstTimeModal.show();
});
