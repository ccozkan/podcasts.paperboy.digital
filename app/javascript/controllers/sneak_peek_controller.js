import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        url: String,
    }

    connect(){
    }

    startSneakPeek() {
        const url = '/start-worker'; // Replace with the actual URL of your Rails controller action
        const params = {
            url: String,
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
            })
            .catch(error => {
                // Handle any errors
                console.error(error);
            });
    }
}
