import Component from '@ember/component';
import { action } from '@ember/object';

export default class MapboxCurrentMouseEventComponent extends Component {
  currentMapMouseEvent = null;

  @action
  handleEvent(e) {
    this.set('currentMapMouseEvent', e);
  }
}
