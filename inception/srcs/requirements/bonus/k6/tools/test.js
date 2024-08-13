import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
	insecureSkipTLSVerify: true,
	stages: [
		{ target: 10, duration: '10s' },
		{ target: 25, duration: '10s' },
		{ target: 50, duration: '10s' },
		{ target: 10, duration: '10s' },
		{ target: 25, duration: '10s' },
		{ target: 10, duration: '10s' },
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
	sleep(1);
}
