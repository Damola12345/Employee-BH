define(function(require) {
	'use strict';

	const interceptor = require('rest/interceptor');

	return interceptor({
		request: function (request /*, config, meta */) {
			if (request.path?.substring(0,5) !== 'https') {
				request.path = 'https' + request.path?.substring(4);
			}

			const auth = window.localStorage.getItem('auth');

			if (auth && request.headers) {
				request.headers.Authorization = "Basic " + auth;
			}

			return request;
		}
	});

});
