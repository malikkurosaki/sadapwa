
require('prompts')({
    type: "text",
    message: "masukkan command",
    name: "command"
}).then(({ command }) => {
    if (!command) return console.log("ok");
    require('child_process').execSync(`${command}`, { stdio: 'inherit', cwd: require('path').join(__dirname, './../') });
});