import EmberObject from '@ember/object';
import { computed } from '@ember/object';
import round from '../utils/round';

export default EmberObject.extend({
  buildings: computed('bluebook', 'lcgms', function() {
    return (
      this.get('bluebook')
    ).concat(
      this.get('lcgms')
    ).compact();
  }),

  enrollmentTotal: computed('buildings.@each.enroll', function() {
    return this.get('buildings').mapBy('enroll').reduce((acc, value) => {
      if (value === undefined) return acc;
      return acc + parseInt(value);
    }, 0);
  }),

  capacityTotal: computed('buildings.@each.capacity', function() {
    return this.get('buildings').map(
      (b) => b.excluded ? 0 : b.capacity
    ).reduce((acc, value) => {
      if (value === undefined) return acc;
      return acc + parseInt(value);
    }, 0);
  }),

  capacityTotalNoAction: computed('buildings.@each.capacityFuture', function() {
    return this.get('buildings').mapBy('capacityFuture').reduce((acc, value) => {
      if (value === undefined) return acc;
      return acc + parseInt(value);
    }, 0);
  }),

  seatsTotal: computed('buildings.@each.seats', function() {
    return this.get('buildings').mapBy('seats').reduce((acc, value) => {
      if (value === undefined) return acc;
      return acc + parseInt(value);
    }, 0);
  }),

  utilizationTotal: computed('enrollmentTotal', 'capacityTotal', function() {
    return round((this.get('enrollmentTotal') / this.get('capacityTotal')), 3);
  })
});