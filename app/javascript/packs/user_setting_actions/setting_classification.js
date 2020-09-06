import {userSettingAction} from './settings';
export function userSettingClassificationAction(
  settingClassificationId,
  eventTarget,
) {
  var form = $(
    `#userSettings #setting_classification_id[value="${settingClassificationId}"]`,
  )[0].form;
  var radio = $(form).find('input[type="radio"]:checked')[0];
  if (!radio) {
    return;
  } else {
    var settingId = parseInt(radio.value);
    userSettingAction(settingId, eventTarget);
  }
}
