/**
 * @author lipeilin
 * @date 2025/8/18
 * @project demo
 * @description 描述信息
 */
import { common, Want } from "@kit.AbilityKit";
import Logger from "./Logger";

const TAG = '[Sample_StartMode]';
let contextCaller: AbilityContext, want:Want;
interface EventHub {
  emit(event: string, ...args: Object[]): void;
}

interface  AbilityContext {
  startAbility(want: Want) : void;
  eventHub: EventHub;
}

let that = this;

class  EventData {
  context: AbilityContext | null = null
  launchWant: Want | null = null
}

export function getContextData(): Want {
  Logger.info(TAG, 'UtilPage getContextData start');
  let context = getContext(that);
  let data: EventData = new EventData();
  context.eventHub.emit('getAbilityData', data);
  contextCaller = data.context as AbilityContext;
  want = data.launchWant as Want;
  Logger.info(TAG, 'UtilPage contextCaller ' + JSON.stringify(contextCaller));
  return want;
}

export function startMode(wantParameters: Record<string, string|number>, abilityName: string) {
  Logger.info(TAG, `${abilityName} start`);
  getContextData();
  let want: Want = {
    bundleName: 'com.example.myapplication',
    abilityName: abilityName,
    parameters: wantParameters
  }
  Logger.info(TAG, `${abilityName} contextCaller ${JSON.stringify(contextCaller)}`);
  try {
    contextCaller.startAbility(want);
  }catch {
    (err: Function) => {
      Logger.info(TAG, 'err is' + JSON.stringify(err));
    }
  }
  Logger.info(TAG, `${abilityName} end`);
}

export function totast(context: common.Context) {
  AlertDialog.show(
    {
      message: $r('app.string.totast'),
      secondaryButton: {
        value: 'ok',
        action: () => {
          Logger.info(TAG, 'Callback when the second button is clicked')
        }
      }
    }
  )
}