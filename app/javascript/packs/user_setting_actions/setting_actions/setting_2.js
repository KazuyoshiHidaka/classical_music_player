export function setting2Action(eventTarget) {
  var iCurrentVideo = window.ytPlayersList.indexOf(eventTarget);
  var iNextVideo = iCurrentVideo + 1;
  if (iNextVideo >= window.ytPlayersList.length) {
    iNextVideo -= window.ytPlayersList.length;
  }
  window.ytPlayersList[iNextVideo].playVideo();
}
