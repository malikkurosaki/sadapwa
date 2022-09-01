const exec = require('child_process').execSync
const path = require('path');

const client = path.join(__dirname, "./mode_client_pro.js");
const server = path.join(__dirname, "./mode_pro.js");
const gitPush = path.join(__dirname, "./git_push.js");
exec(`node ${client}`, { stdio: "inherit" });
exec(`node ${server}`, { stdio: "inherit" });

exec(`flutter build appbundle`, { stdio: "inherit", cwd: path.join(__dirname, "../") });
exec(`node ${gitPush}`, { stdio: "inherit" });
