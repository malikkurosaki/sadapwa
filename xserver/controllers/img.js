const expressAsyncHandler = require('express-async-handler');
const fs = require('fs');
const path = require('path');

async function getImg(name) {
    const imgPath = path.join(__dirname, './../assets', name);
    if (!fs.existsSync(imgPath)) {
        return null;
    }
    return path.join(__dirname, './../assets/' + name);
}

const getImage = expressAsyncHandler(async (req, res) => {
    const name = req.params.name;
    const img = await getImg(name);

    res.type("image/jpeg").sendFile(img ?? path.join(__dirname, './../no-image.png'));
});

const Img = { getImage };
module.exports = Img