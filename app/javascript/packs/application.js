require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

var jQuery = require('jquery');

// import jQuery from 'jquery';
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

import 'bootstrap'
