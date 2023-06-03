import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String
    }

    play() {
        this.player = document.getElementById("player");
        this.player.src = this.urlValue;
        this.player.play();
    }

    fastForward() {
        this.player = document.getElementById("player");
        this.player.currentTime += 15;
    }

    fastReverse() {
        this.player = document.getElementById("player");
        this.player.currentTime -= 15;
    }
}
