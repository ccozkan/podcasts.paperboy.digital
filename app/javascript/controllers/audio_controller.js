import { Controller } from "@hotwired/stimulus";
import Plyr from "plyr";

export default class extends Controller {
    static values = {
        url: String
    }

    initialize() {
        const player = new Plyr('#player');
        console.log(this.urlValue);
    }

    next(event) {
        var aud = document.getElementById("player");
        aud.src = this.urlValue;
        aud.play();
    }
}
