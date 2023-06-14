import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ['output'];
    static values = {
        feedSlug: String,
        feedExternalId: String,
    }


    connect() {
        this.startInterval();
    }

    startInterval() {
        this.updateData(); // Perform the initial request immediately

        this.interval = setInterval(() => {
            this.updateData();
        }, 1000); // Make the request every second, adjust as needed
    }

    stopInterval() {
        clearInterval(this.interval);
    }
    updateData() {
        const url = '/sneak-peekable'; // Replace with the actual path you want to request
        const params = {
            episode_external_id: 'value2',
        };

        const queryString = new URLSearchParams(params).toString();
        const requestUrl = url + '?' + queryString;

        fetch(requestUrl)
            .then(response => response.json())
            .then(data => {
                if (data.status === true) {
                    window.location.href = '/redirect_path'; // Replace with the actual path you want to redirect to
                } else {
                    this.outputTarget.textContent = 'Response is false'; // Update the output with the response data (for testing purposes)
                }
            })
            .catch(error => {
                console.error(error);
            });
    }
}
