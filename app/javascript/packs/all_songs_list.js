document.addEventListener('turbolinks:load', function () {
  var songLinkId = $('#allSongsList').data('selected-song-link');
  if (!songLinkId) {
    return;
  }
  var sidebar = $('#songsListsSidebar');
  openSongParentCollapses(songLinkId, sidebar, 'smooth');

  var modal = $('#songsListsModal');
  modal.one('shown.bs.modal', function () {
    openSongParentCollapses(songLinkId, modal);
  });
});

function openSongParentCollapses(
  songLinkId,
  container,
  scrollBehavior = 'auto',
) {
  var songLink = container.find(`#${songLinkId}`);
  var parentCollapses = songLink.parents('.collapse');
  $(parentCollapses[1]).on('hidden.bs.collapse', (e) => {
    var collapseBtn = container.find(
      `[data-toggle="collapse"][href="#${e.target.id}"]`,
    );
    collapseBtn.addClass('collapsed');
  });
  $(parentCollapses[1]).on('shown.bs.collapse', (e) => {
    var collapseBtn = container.find(
      `[data-toggle="collapse"][href="#${e.target.id}"]`,
    );
    collapseBtn.removeClass('collapsed');
  });
  $(parentCollapses[0]).one('shown.bs.collapse', () => {
    songLink[0].scrollIntoView({
      behavior: scrollBehavior,
      block: 'center',
    });
  });
  parentCollapses.collapse();
  songLink.addClass('border-left-blue');
}
