import { helper } from '@ember/component/helper';
/**
 * Helper for CensusTractsTable component that calculates a modal split percent for a
 * single modal split. Accepts multiple variables, so modal splits for a random subset of
 * modes can be calculated
 */
export function getSplitPercent(params/* , hash */) {
  const [modalSplitData, variables] = params;

  if (modalSplitData && variables && Array.isArray(variables)) {
    // calculate the sum of given variables for the modal split
    const partTotal = variables.reduce((runningSum, variable) => (modalSplitData[variable] ? runningSum + modalSplitData[variable].value : runningSum),
      0);
    // calculate percent
    const percent = modalSplitData.trans_commuter_total ? (partTotal / modalSplitData.trans_commuter_total.value) * 100 : undefined;

    // return formatted percent
    return isNaN(percent) ? '-' : `${percent.toFixed(1)} %`;
  }
}

export default helper(getSplitPercent);
