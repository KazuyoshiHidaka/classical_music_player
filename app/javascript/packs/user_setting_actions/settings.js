import * as settingActions from './setting_actions/index';
export function userSettingAction(settingId, eventTarget) {
  switch (settingId) {
    case 1:
      settingActions.setting1Action();
      break;

    case 2:
      settingActions.setting2Action(eventTarget);
      break;

    case 3:
      settingActions.setting3Action(eventTarget);
      break;
  }
}
