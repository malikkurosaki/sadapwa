const path = require('path')
require('child_process').execSync(`nodemon index.js`, { stdio: "inherit", cwd: path.join(__dirname, './../xserver') })