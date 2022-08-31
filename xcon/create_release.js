#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const beauty = require('js-beautify');
require('prompts')({
    type: "password",
    name: "password",
    message: "passwordnya"
}).then(({ password }) => {
    if (!password) return console.log("ho oh");
    // pass nyambung semua
    const tem = `
    storePassword=${password}
    keyPassword=${password}
    keyAlias=malikkurosaki
    storeFile=/Users/probus/Documents/malikkurosaki.jks
    `

    fs.writeFileSync(path.join(__dirname, "./../android/key.properties"), tem)
    let target = fs.readFileSync(path.join(__dirname, "./../android/app/build.gradle"), "utf8").toString();

    const tem2 =
        `
    def keystoreProperties = new Properties()
    def keystorePropertiesFile = rootProject.file('key.properties')
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
    }

    android {
    `

    const tem3 =
        `
        signingConfigs {
            release {
                keyAlias keystoreProperties['keyAlias']
                keyPassword keystoreProperties['keyPassword']
                storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
                storePassword keystoreProperties['storePassword']
            }
        }

        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }
    }
    `

    let target2 = target.replace(/android.*\{\n/g, tem2);
    let cocok = target2.match(/buildTypes.*\{[\s\S]+\}.*[\n]+\}/g)

    fs.writeFileSync(path.join(__dirname, "./../android/app/build.gradle"), target2.replace(cocok[0], tem3))

});

