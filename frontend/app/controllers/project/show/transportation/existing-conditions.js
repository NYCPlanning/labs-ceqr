import Controller from '@ember/controller';
import { inject as service } from '@ember-decorators/service';
import { computed } from '@ember-decorators/object';
import { VARIABLE_MODE_LOOKUP, COMMUTER_VARIABLES, MODAL_SPLIT_VARIABLES_SUBSET } from '../../../../utils/modalSplit';
import { alias } from '@ember-decorators/object/computed';

export default class ProjectShowTransportationExistingConditionsController extends Controller {

  @service store;
  @service('readonly-ceqr-data-store') readonlyStore;

  commuterModes = COMMUTER_VARIABLES;
  modeLookup = VARIABLE_MODE_LOOKUP;

  modalSplitVariablesSubset = MODAL_SPLIT_VARIABLES_SUBSET;

  isRJTW = false;

  @alias('model.transportationAnalysis') analysis;

  /**
   * Composite array containing geoids of all selected census tracts
   */
  @computed('analysis.{requiredJtwStudySelection.[],jtwStudySelection.[]}')
  get selectedCensusTractIds() {
    if(this.model){
      return [...this.analysis.jtwStudySelection, ...this.analysis.requiredJtwStudySelection];
    }
    return [];
  }

  /**
   * Promise that resolves to an array of modal-split objects for the selected census-tracts
   */
  @computed('isRJTW', 'analysis.{requiredJtwStudySelection.[],jtwStudySelection.[]}')
  get selectedCensusTractData() {
    const readonlyStore = this.get('readonlyStore');
    const selectedIds = this.get('selectedCensusTractIds');
    let selectedData = this.isRJTW ? readonlyStore.findByIds('CTPP-modal-split', selectedIds) : readonlyStore.findByIds('ACS-modal-split', selectedIds);
    return selectedData;
  }

}
