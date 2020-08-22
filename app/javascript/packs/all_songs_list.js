document.addEventListener('turbolinks:load', function () {
  const sidebar = $('#songsListsSidebar');
  const songInSidebar = sidebar
    .find('.border-left-blue')
    .not('[data-toggle="collapse"]')[0];
  if (songInSidebar != undefined) {
    songInSidebar.scrollIntoView({
      behavior: 'smooth',
      block: 'center',
    });
  }

  const modal = $('#songsListsModal');
  const songInModal = modal
    .find('.border-left-blue')
    .not('[data-toggle="collapse"]')[0];
  modal.on('shown.bs.modal', function (_) {
    if (songInModal != undefined) {
      songInModal.scrollIntoView({
        block: 'center',
      });
    }
  });
});
