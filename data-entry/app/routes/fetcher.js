import Route from '@ember/routing/route';
import { action } from '@ember/object'
import { tracked } from '@glimmer/tracking';

const DB_URL = "http://127.0.0.1:8000";

export default Ember.Route.extend({
    model: async function (params) {
        this.fetchData()
    },

    actions: {
        deleteUser: function (user_id) {
            console.log("in Route");
            console.log(user_id);
        }   
    },

    fetchData() {
        this.controllerFor('fetcher').send('fetchData');
    }
});
