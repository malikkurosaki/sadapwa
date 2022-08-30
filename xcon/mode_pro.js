const fs = require('fs');
const path = require('path');

const template = `require('./server_ssl.js')`;

fs.writeFileSync(path.join(__dirname, '../xserver/index.js'), template);
console.log("berhasil");


