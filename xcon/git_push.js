#!/usr/bin/env node
const exec = require('child_process').execSync
const path = require('path');


require('./mode_client_pro');
require('./mode_pro');

exec(`git add . && git commit -m "$(date)" && git push origin main`, { stdio: "inherit", cwd: path.join(__dirname, "./../") })
console.log("push finis");