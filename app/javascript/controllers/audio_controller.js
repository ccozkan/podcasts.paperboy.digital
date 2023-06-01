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
      // console.log(aud);
      // fetch(this.urlValue).then(
      //     aud.src = "https://chrt.fm/track/GF1E57/traffic.megaphone.fm/TAMC2111426415.mp3?updated=1685311924"
      // );
        // player.play();
    }
}
