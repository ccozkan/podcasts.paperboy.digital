import { Controller } from "@hotwired/stimulus";
// import Plyr from "plyr";

export default class extends Controller {
    static values = {
        url: String
    }

    initialize() {
        // this.player = new Plyr('#player');
        this.player = document.getElementById("player");
        console.log(this.urlValue);
    }

    change(event) {
        // this.player.source = this.urlValue;
        // this.player.play();
        this.player.src = this.urlValue;
        this.player.play();
    }

    fastForward() {
        this.player.currentTime += 15;
    }

    fastReverse() {
        this.player.currentTime -= 15;
    }
}
