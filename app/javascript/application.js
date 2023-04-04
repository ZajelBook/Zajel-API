// Entry point for the build script in your package.json
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import "./channels"
