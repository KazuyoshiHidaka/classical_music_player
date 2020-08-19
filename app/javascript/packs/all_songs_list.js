document.addEventListener('turbolinks:load', function () {
  const container = $('#songsListContainer');
  const songContainer = container
    .find('.border-left-blue')
    .not('[data-toggle="collapse"]')[0];
  songContainer.scrollIntoView({
    behavior: 'smooth',
    block: 'center',
  });

  const modal = $('#songsListModal');
  const songModal = modal
    .find('.border-left-blue')
    .not('[data-toggle="collapse"]')[0];
  modal.on('shown.bs.modal', function (_) {
    songModal.scrollIntoView({
      block: 'center',
    });
  });
});
