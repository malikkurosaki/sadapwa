const https = require('https');
const fs = require("fs");
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3002;
const cors = require('cors');
const api = require('./apis/api');
const path = require('path');
// const ip = require('ip');

app.use(cors())
app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use(api)


https.createServer(
    {
        key: fs.readFileSync(path.join(__dirname, './key.pem')),
        cert: fs.readFileSync(path.join(__dirname, './cert.pem')),
    },
    app).listen(PORT, () => {
        console.log(`Listening https://${PORT}`);
    });
