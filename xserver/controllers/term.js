const exh = require('express-async-handler');
const fs = require('fs');
const path = require('path');

const getData = exh(async (req, res) => {
    res.send(fs.readFileSync(path.join(__dirname, "../contents/terms&conditions.md"), "utf8").toString());
});

const Term = { getData };
module.exports = Term