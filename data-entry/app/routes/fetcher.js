import Route from '@ember/routing/route';
import { tracked } from '@glimmer/tracking';

const DB_URL = "http://127.0.0.1:8000/";

export default class FetcherRoute extends Route {
    @tracked isLoaded = false;
    @tracked users;

    async model() {
        let xhr = new XMLHttpRequest();
        xhr.open('GET', DB_URL + "get-users", true);

        console.log(this.isLoaded);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                this.users = JSON.parse(xhr.response);
                console.log(this.users);
                this.isLoaded = true;
            }
        }
        xhr.send();
    }
}