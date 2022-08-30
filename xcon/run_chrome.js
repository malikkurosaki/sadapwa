const exec = require('child_process').execSync
const path = require('path')
exec(`flutter run -d chrome`, { stdio: 'inherit' })