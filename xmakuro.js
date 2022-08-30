#!/usr/bin/env node
const prompts = require('prompts');
const fs = require('fs');
const path = require('path');
const exec = require('child_process').execSync
const _ = require('lodash');
const dir = fs.readdirSync(path.join(__dirname, './xcon'));

prompts({
    type: "autocomplete",
    message: "dipilih aja menunya",
    name: "apa",
    choices: dir.map(e => {
        return {
            title: e.split(".")[0],
            value: e
        }
    })
}).then(({ apa }) => exec(`node ${apa}`, { stdio: "inherit", cwd: path.join(__dirname, './xcon') }));
