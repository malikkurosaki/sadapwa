const expressAsyncHandler = require('express-async-handler');
const path = require('path');
const fs = require('fs');

const getContent = expressAsyncHandler(async (req, res) => {
    const data = fs.readFileSync(path.join(__dirname, '../contents/wa.json'), 'utf8').toString();
    res.json(JSON.parse(data));
})

const Content = { getContent }
module.exports = Content