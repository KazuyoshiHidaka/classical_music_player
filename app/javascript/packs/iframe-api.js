import { userSettingClassificationAction } from './user_setting_actions/setting_classification';

window.autoplayFirstVideo = false;
window.onYouTubeIframeAPIReady = function () {
  window.ytPlayersList = [];

  $('div[id^="youtubeVideoId"]').each((i, video) => {
    var videoId = video.id.replace('youtubeVideoId', '');
    var playerEvents = {
      onStateChange: onPlayerStateChange,
    };
    var playerVars = {};
    if (i == 0 && window.autoplayFirstVideo) {
      window.autoplayFirstVideo = false;
      playerEvents.onReady = onPlayerReady;
      playerVars.autoplay = 1;
    }
    var player = new YT.Player(video, {
      videoId: videoId,
      events: playerEvents,
      playerVars: playerVars,
    });
    ytPlayersList.push(player);
  });
};

function onPlayerReady(event) {
  event.target.playVideo();
}

function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.ENDED) {
    userSettingClassificationAction(1, event.target);
  }
}

document.addEventListener('turbolinks:load', function () {
  if (window.YT) {
    onYouTubeIframeAPIReady();
  } else {
    var tag = document.createElement('script');
    tag.src = 'https://www.youtube.com/iframe_api';
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
  }
});
