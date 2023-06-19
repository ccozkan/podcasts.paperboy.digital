import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String,
        text: String,
        episodeUrl: String,
    }

    handleChange(){
        this.play();
        this.updateText();
        this.updateLink();
    }

    play() {
        this.player = document.getElementById("player");
        this.player.src = this.urlValue;
        this.player.play();
    }

    updateText() {
        var text = document.getElementById("currentlyPlaying");
        text.innerHTML = this.textValue;
    }

    updateLink() {
        var link = document.getElementById("currentlyPlayingEpisodeLink");
        link.setAttribute("href", this.episodeUrlValue);
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
