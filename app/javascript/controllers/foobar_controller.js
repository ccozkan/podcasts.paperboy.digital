import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String,
    }

    connect(){
    }

    checkJobCompletion(jobId) {
        const interval = setInterval(() => {
            $.get(`/check_job_completion/${jobId}`)
                .done((data) => {
                    if (data.completed) {
                        clearInterval(interval);
                        this.redirectToBackgroundProcessComplete();
                    }
                });
        }, 1000); // Poll every second, adjust as needed
    }

    checkJob(jobId) {
        const url = '/start-worker'; // Replace with the actual URL of your Rails controller action
        const params = { 
            url: jobId,
        };
        const interval = setInterval(() => {
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
                },
                body: JSON.stringify(params)
            })
                .then(response => response.json())
                .then(data => {
                    // Handle the response
                    console.log(data);
                    this.cagri(data);
                })
                .catch(error => {
                    // Handle any errors
                    console.error(error);
                });
        }, 1000); // Poll every second, adjust as needed
    }

    sendPostRequest() {
        const url = '/start-worker'; // Replace with the actual URL of your Rails controller action
        const params = { 
            url: this.urlValue,
        };

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify(params)
        })
            .then(response => response.json())
            .then(data => {
                // Handle the response
                console.log(data);
                this.cagri(data);
            })
            .catch(error => {
                // Handle any errors
                console.error(error);
            });
    }

    cagri(data) {
        console.log(data);
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
