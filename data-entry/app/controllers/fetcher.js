import Controller from '@ember/controller';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

const DB_URL = "http://127.0.0.1:8000";

export default Ember.Controller.extend({
    isLoading: true,
    users: [],
    actions: {
        async fetchData() {
            this.set('isLoading', true);
            let xhr = new XMLHttpRequest();
            xhr.open('GET', DB_URL + "/get-users", true);

            xhr.send();

            var x = await new Promise(function (resolve, reject) {
                xhr.onload = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var users = JSON.parse(xhr.response);
                        console.log(`Length: ${users.length}`);
                        resolve(users);
                    } else resolve("Error !");
                }
            }).then(
                result => {
                    this.set('users', result);
                    this.set('isLoading', false);

                    return result;
                },
                error => console.log(error)
            );
            console.log("X :");
            console.log(x);
            return x;
        },

        deleteUser(user_id, callback) {
            console.log("in Controller");
            console.log(`User (${user_id}) will be deleted`);

            var confirm = window.confirm(`Are you sure you want to detele ${user_id}? This process cannot be reversed!`);
            if (!confirm)
                return;


            console.log(callback, typeof (callback));
            var xhr = new XMLHttpRequest();
            xhr.open('POST', DB_URL + '/delete-user', true);

            xhr.setRequestHeader('content-type', 'multipart/form-data;');

            xhr.send(user_id);
            new Promise((resolve, reject) => {
                xhr.onload = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log(`Response: ${xhr.response}`);
                        resolve(true);
                    } else reject(false);
                }
            }).then(result => {
                if (result) callback();
            });
        }
    },
});