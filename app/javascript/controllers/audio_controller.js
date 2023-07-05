import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String,
        text: String,
        episodeUrl: String,
        episodeId: String,
        bookmarkedAtSecond: Number,
    }

    connect() {
        var player = document.getElementById("player");

        if (player?.src == '' || player?.paused == true) {
            player.style.visibility = "hidden";
        }
    }

    handleChange(){
        this.player = document.getElementById("player");
        this.player.style.visibility = "visible";
        this.player.currentTime = this.bookmarkedAtSecondValue;
        this.play();
        this.updateText();
        this.updateLink();
        this.updateBookmarkLink();
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

    updateBookmarkLink() {
        var button = document.getElementById("bookmarkerButton");
        var path = '/bookmark/' + this.episodeIdValue;
        button.form.setAttribute("action", path);
        button.form.setAttribute("method", "put");
    }

    handleBookmarking() {
        const hiddenField = document.getElementById("bookmarkerSecond");
        this.player = document.getElementById("player");
        hiddenField.value = this.player.currentTime;
    }


    fastForward() {
        this.player = document.getElementById("player");
        this.player.currentTime += 15;
    }

    fastReverse() {
        this.player = document.getElementById("player");
        this.player.currentTime -= 15;
    }

    updateBookmarkLink2() {
        var button = document.getElementById("bookmarkCurrentlyPlayingEpisode");
        var path = '/bookmark/' + this.episodeIdValue;
        button.form.setAttribute("action", path);
    }
}
