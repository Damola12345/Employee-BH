'use strict';

const SockJS = require('sockjs-client');
require('stompjs');

function register(registrations) {
	const socket = SockJS(`${process.env.API_URL}/payroll`);
	const stompClient = Stomp.over(socket);
	stompClient.connect({ "Authorization": "Basic " + window.localStorage.getItem("auth") }, function(frame) {
		registrations.forEach(function (registration) {
			stompClient.subscribe(registration.route, registration.callback);
		});
	});
}

module.exports = {
	register: register
};

