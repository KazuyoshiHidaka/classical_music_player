window.addEventListener('beforeunload', () => {
  if (document.fullscreenElement) {
    document.exitFullscreen();
  }
});

document.addEventListener('turbolinks:before-visit', function () {
  if (document.fullscreenElement) {
    document.exitFullscreen();
  }
});