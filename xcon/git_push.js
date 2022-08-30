#!/usr/bin/env node
const exec = require('child_process').execSync
const path = require('path');

exec(`git add . && git commit -m "$(date)" && git push origin main`, { stdio: "inherit", cwd: path.join(__dirname, "./../") })