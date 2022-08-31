const exec = require('child_process').execSync;
const path = require('path');

exec(`flutter build apk --release`, {stdio: "inherit", cwd: path.join(__dirname, "../")});