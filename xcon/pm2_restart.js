#!/usr/bin/env node
require('child_process').execSync(`pm2 restart all`, { stdio: 'inherit' })