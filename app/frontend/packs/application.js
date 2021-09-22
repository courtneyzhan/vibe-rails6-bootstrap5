// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "jquery"
import "@fortawesome/fontawesome-free/js/all";

// import Highcharts from 'highcharts';

// seems just import all (see below) workl better? can't import both
// import '../js/bootstrap_js_files.js'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.js';

import Highcharts from 'highcharts'
window.Highcharts = Highcharts;

$(document).ready(function(){ 

    Rails.confirm = function(message, element) {
        var myModal = new bootstrap.Modal(document.getElementById('confirmation-modal'), {});
        $('#modal-content').text(message);
        $("#confirm-ok-button").click(function(event) {
            event.preventDefault()
            myModal.dispose();
            let old = Rails.confirm
            Rails.confirm = function() { return true }
            let $element = $(element)            
            $element.get(0).click()
            Rails.confirm = old;            
        });
        myModal.show();        
        return false;
    }
        
});