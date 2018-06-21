import Route from '@ember/routing/route';
import RSVP from 'rsvp';

export default class ProjectRoute extends Route {
  model = async function(params) {
    const project = await this.get('store').findRecord('project', params.project_id);
    const ceqrManual = await this.get('store').findRecord('ceqr-manual', 'march-2014');

    project.setCeqrManual(ceqrManual);
    
    return RSVP.hash({
      project,
      ceqrManual,
    });
  }

  controllerName = 'project';
};