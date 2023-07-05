import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        externalId: String,
    }

    connect() {
        this.startInterval();
    }

    startInterval() {
        this.interval = setInterval(() => {
            this.askPeekable();
        }, 2000);
    }

    stopInterval() {
        clearInterval(this.interval);
    }

    askPeekable() {
        const url = '/peekable';
        const params = {
            external_id: this.externalIdValue,
        };

        const queryString = new URLSearchParams(params).toString();
        const requestUrl = url + '?' + queryString;

        fetch(requestUrl)
            .then(response => response.json())
            .then(data => {
                if (data.status === true) {
                    window.location.href = '/peek?external_id=' + this.externalIdValue;
                }
            })
            .catch(error => {
                console.error(error);
            });
    }
}
