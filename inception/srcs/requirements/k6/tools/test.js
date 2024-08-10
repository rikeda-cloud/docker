import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
	insecureSkipTLSVerify: true,
	stages: [
		{ target: 10, duration: '20s' },
		{ target: 50, duration: '20s' },
		{ target: 100, duration: '20s' },
		{ target: 20, duration: '20s' },
		{ target: 50, duration: '20s' },
		{ target: 10, duration: '20s' },
	]
};

export default function() {
	const res = http.get('https://nginx/rust/');
	check(res, {
		'response code == 200': (res) => res.status === 200,
	});
	sleep(1);
}
