#!/usr/bin/env node
require('prompts')({
    type: 'password',
    message: "masukkan password",
    name: 'pass',
}).then(({pass}) => {
    if(!pass) return console.log('No password provided');
    require('child_process').execSync(`sshpass -p ${pass} ssh makuro@makurostudio.my.id`, {stdio: "inherit"})
});