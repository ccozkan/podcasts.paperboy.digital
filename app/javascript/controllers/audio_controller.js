import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String,
        text: String,
    }

    handleChange(){
        this.play();
        this.updateText();
    }

    play() {
        this.player = document.getElementById("player");
        this.player.src = this.urlValue;
        this.player.play();
        this.updateText();
    }

    updateText() {
        var text = document.getElementById("currentlyPlaying");
        console.log(this.textValue);
        text.innerHTML = this.textValue;
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
