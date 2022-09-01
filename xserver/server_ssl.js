const https = require('https');
const path = require('path');
const {app, PORT} = require('./server_util.js')
const fs = require("fs");

https.createServer(
    {
        key: fs.readFileSync(path.join(__dirname, './key.pem')),
        cert: fs.readFileSync(path.join(__dirname, './cert.pem')),
    },
    app).listen(PORT, () => {
        console.log(`Listening https://${PORT}`);
    });
