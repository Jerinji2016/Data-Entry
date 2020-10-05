import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

const DB_URL = "http://127.0.0.1:8000";

export default class FeederComponent extends Component {
    @tracked id = '';
    @tracked name = '';
    @tracked imgUrl = '';
    @tracked phone = '';
    @tracked email = '';

    @tracked success = false;
    @tracked errorMsg = null;
    @tracked error = false;

    showError(msg) {
        this.error = true;
        this.errorMsg = msg;

        Ember.run.later(() => {
            this.error = false;
        }, 3000);
    }

    @action submit() {
        if (this.checkFieldError()) {
            console.log("error");
            return;
        }
        var user = {
            'id': this.id,
            'name': this.name,
            'imageURL': this.imgUrl,
            'phone': this.phone,
            'email': this.email
        };

        var xhr = new XMLHttpRequest();
        var url = DB_URL + "/add";
        console.log(url);

        xhr.open("POST", url, true);
        xhr.setRequestHeader('content-type', 'multipart/form-data;');

        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log((JSON.parse(xhr.response).result));
                id = '';
                email = '';
                name = '';
                phone = '';
                imgUrl = '';

                success = true;
                Ember.run.later(() => {
                    this.success = false;
                }, 2000);
            } else {
                this.error = true;
                this.errorMsg = "Something went wrong. Please try again!";

                Ember.run.later(() => {
                    this.error = false;
                }, 3000);
            }
        }

        xhr.send(JSON.stringify(user));
    }

    checkFieldError() {
        this.errorMsg = null;
        if (this.id.length == 0) {
            this.showError("ID cannot be empty");
            return true;
        }
        if (this.name.length == 0) {
            this.showError("Name cannot be empty");
            return true;
        }
        if (this.email.length == 0) {
            this.showError("Email cannot be empty");
            return true;
        }
        if (this.phone.length == 0) {
            this.showError("Phone cannot be empty");
            return true;
        }
        if (this.imgUrl.length == 0) {
            this.showError("Image URL cannot be empty");
            return true;
        }

        return false;
    }

    @action checkValidId() {
        let xhr = new XMLHttpRequest();
        var url = DB_URL + "/check-availability";

        xhr.open("POST", url, true);
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4 && xhr.status == 200) {
                if (!(JSON.parse(xhr.response).available))
                    this.showError("That ID is already taken");
            }
        }
    }
}