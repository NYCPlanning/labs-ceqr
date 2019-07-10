import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import hbs from 'htmlbars-inline-precompile';

module('Integration | Component | transportation/trip-generation-tables/modal-splits-vehicle-occupancy', function(hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function(assert) {
    // Set any properties with this.set('myProperty', 'value');
    // Handle any actions with this.set('myAction', function(val) { ... });

    await render(hbs`{{transportation/trip-generation-tables/modal-splits-vehicle-occupancy}}`);

    assert.equal(this.element.textContent.trim(), '');

    // Template block usage:
    await render(hbs`
      {{#transportation/trip-generation-tables/modal-splits-vehicle-occupancy}}
        template block text
      {{/transportation/trip-generation-tables/modal-splits-vehicle-occupancy}}
    `);

    assert.equal(this.element.textContent.trim(), 'template block text');
  });
});
