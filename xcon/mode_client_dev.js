#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const template = `static const host = "http://localhost:3002";`
const target = fs.readFileSync(path.join(__dirname, './../lib/pref.dart')).toString()

const cari = target.match(/static const host = "(.*)";/g)
const maka = target.replace(cari[0], template);
fs.writeFileSync(path.join(__dirname, './../lib/pref.dart'), maka);

