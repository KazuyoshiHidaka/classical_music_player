const Rails = require('@rails/ujs');

document.addEventListener('turbolinks:load', function () {
  $(document).on('change', '#userSettings input[type="checkbox"]', (e) => {
    const checkbox = e.target;
    Rails.fire(checkbox.form, 'submit');
  });
});
