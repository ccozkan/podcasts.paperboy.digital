import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        externalId: String,
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
            external_id: this.externalIdValue,
        };

        const queryString = new URLSearchParams(params).toString();
        const requestUrl = url + '?external_id=' + queryString;

        fetch(requestUrl)
            .then(response => response.json())
            .then(data => {
                if (data.status === false) {
                    this.outputTarget.textContent = 'Response is false'; // Update the output with the response data (for testing purposes)
                } else {
                    window.location.href = '/sneak-peek?external_id=' + this.externalIdValue;
                }
            })
            .catch(error => {
                console.error(error);
            });

    }
}
