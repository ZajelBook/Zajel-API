import { Controller } from "@hotwired/stimulus"
import Cookies from 'js-cookie'

const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
};

// Connects to data-controller="geolocation"
export default class extends Controller {
    connect() {
        console.log('i am here')
    }

    success(pos) {
        const crd = pos.coords;

        console.log('Your current position is:');
        console.log(`Latitude : ${crd.latitude}`);
        console.log(`Longitude: ${crd.longitude}`);
        console.log(`More or less ${crd.accuracy} meters.`);
        Cookies.set('latitude', `${crd.latitude}`)
        Cookies.set('longitude', `${crd.longitude}`)
    }

    error(err) {
        console.warn(`ERROR(${err.code}): ${err.message}`);
    }

    search () {
        navigator.geolocation.getCurrentPosition(this.success, this.error, options);
    }
}