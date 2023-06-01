import { Controller } from "@hotwired/stimulus";
import Plyr from "plyr";

export default class extends Controller {
    static values = {
        url: String
    }

    initialize() {
        this.player = new Plyr('#player');
        console.log(this.urlValue);
    }

    next(event) {
        this.player.src = this.urlValue;
        this.player.play();
        // var aud = document.getElementById("player");
        // aud.src = this.urlValue;
        // aud.play();
    }
}
