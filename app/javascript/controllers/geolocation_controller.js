import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

// Connects to data-controller="geolocation"
export default class extends Controller {
    connect() {
        const nextTimestamp = Date.now() - 24 * 60 * 60 * 1000;

        if (Cookies.get('latitude') && Cookies.get('crdTimestamp') > nextTimestamp) {
            return;
        }

        $('#myModal').modal('show')

        navigator.geolocation.getCurrentPosition(
            position => {
                // Do something with the location
                const crd = position.coords;
                const timestamp = Date.now();

                Cookies.set('latitude', `${crd.latitude}`)
                Cookies.set('longitude', `${crd.longitude}`)
                Cookies.set('crdTimestamp', `${timestamp}`)

                const params = new URLSearchParams(window.location.search);
                const redirectUrl = params.get('redirect');

                if (redirectUrl) {
                    window.location.href = redirectUrl;
                } else {
                    location.reload();
                }
            },
            error => {
                // Hide the loading indicator
                const loaderText = document.querySelector('#loader-text');
                loaderText.innerHTML = "We couldn't access your location. Please enable your location services and try again";
            }
        );
    }
}