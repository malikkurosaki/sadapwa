const Content = require('../controllers/content');
const Img = require('../controllers/img');
const Privacy = require('../controllers/privacy');
const Term = require('../controllers/term');
const api = require('express').Router();

// home
api.get('/', (req, res) => {
    res.send("Wellcome To MenyadapWa")
})

// img
api.get('/img/:name', Img.getImage)

// content
api.get('/ctn', Content.getContent)

// term 
api.get('/term', Term.getData);

// privacy
api.get('/privacy', Privacy.getData)



module.exports = api