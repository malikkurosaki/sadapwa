#!/usr/bin/env node
require(`child_process`).execSync(`npm install`, { stdio: "inherit", cwd: require('path').join(__dirname, './../xserver') });