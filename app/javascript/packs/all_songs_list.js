
document.addEventListener('cached-all-songs-list-load', function () {
  var songLinkId = $('#allSongsList').data('selected-song-link');
  if (!songLinkId) {
    return;
  }
  var sidebar = $('#songsListsSidebar');
  openSongParentCollapses(songLinkId, sidebar);

  var modal = $('#songsListsModal');
  modal.one('shown.bs.modal', function () {
    openSongParentCollapses(songLinkId, modal);
  });
});

function openSongParentCollapses(
  songLinkId,
  container,
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
    setTimeout(() => {
      songLink[0].scrollIntoView({
        block: 'center',
      });
    }, 500);
  });
  parentCollapses.collapse();
  songLink.addClass('border-left-blue');
}