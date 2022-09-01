const exec = require('child_process').execSync;
const path = require('path');

exec(`flutter run --release`, { stdio: "inherit", cwd: path.join(__dirname, "../") })