const exec = require('child_process').execSync
const path = require('path');
exec(`flutter build appbundle`, { stdio: "inherit", cwd: path.join(__dirname, "../") });
