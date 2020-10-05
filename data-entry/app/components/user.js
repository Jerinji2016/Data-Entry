import Component from '@glimmer/component';
import { action } from "@ember/object";


export default class UserComponent extends Component {

    @action
    delete() {
        var { del } = this.args;
        del();
    }
}
