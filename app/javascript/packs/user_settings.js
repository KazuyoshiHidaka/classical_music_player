const Rails = require('@rails/ujs');

$(document).on('mousedown', '#userSettings form label', (e) => {
  var radio = $(e.currentTarget).find('input[type="radio"]')[0];
  if (radio == undefined) {
    return;
  }
  var checked = radio.checked;

  $(radio).off('click');
  $(radio).on('click', (_) => {
    if (checked == true) {
      radio.checked = false;
    }
    Rails.fire(radio.form, 'submit');
  });
});
