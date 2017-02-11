/*
// curl -k https://localhost:8000/
const https = require('https');
const fs = require('fs');

const options = {
	key: fs.readFileSync('./localhost.key'),
	cert: fs.readFileSync('./localhost.crt')
};

https.createServer(options, (req, res) => {
	res.writeHead(200);
	res.end('hello world\n');
}).listen(8000);*/


/*var crypto = require('crypto');

var diffHell = crypto.createDiffieHellman(1024);

diffHell.generateKeys();
console.log("Public Key : " ,diffHell.getPublicKey('base64'));
console.log("Private Key : " ,diffHell.getPrivateKey('base64'));*/

//console.log("Public Key : " ,diffHell.getPublicKey('hex'));
//console.log("Private Key : " ,diffHell.getPrivateKey('hex'));


const crypto = require('crypto');
//const assert = require('assert');

// Generate Alice's keys...
const alice = crypto.createECDH('sect571r1');
const alice_key = alice.generateKeys();

console.log("Public Key (base64): ", alice.getPublicKey('base64'));
console.log("Private Key: ", alice.getPrivateKey('base64'));

// // Generate Bob's keys...
// const bob = crypto.createECDH('secp521r1');
// const bob_key = bob.generateKeys();
//
// // Exchange and generate the secret...
// const alice_secret = alice.computeSecret(bob_key);
// const bob_secret = bob.computeSecret(alice_key);
//
// assert(alice_secret, bob_secret);
// OK

//console.log(crypto.getCurves());