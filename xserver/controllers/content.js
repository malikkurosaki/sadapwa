const expressAsyncHandler = require('express-async-handler');
const path = require('path');
const fs = require('fs');

const getContent = expressAsyncHandler(async (req, res) => {
    const data = fs.readFileSync(path.join(__dirname, '../contents/satu.md'), 'utf8').toString();
    res.json({
        title: "Berbagai Cara Sadap WA",
        img: "sadap.png",
        data: data
    });
})

const Content = { getContent }
module.exports = Content