import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
	insecureSkipTLSVerify: true,
	stages: [
		{ target: 1, duration: '30s' },
		{ target: 3, duration: '20s' },
		{ target: 5, duration: '10s' },
		{ target: 1, duration: '30s' },
		{ target: 3, duration: '20s' },
		{ target: 1, duration: '30s' },
	]
};

export default function() {
	const responses = http.batch([
		['GET', "https://nginx/rust/"],
		['GET', "https://nginx/adminer"],
	])

	for (res of responses) {
		check(res, {
			'response code == 200': (res) => res.status === 200,
		});
	}
	sleep(5);
}
