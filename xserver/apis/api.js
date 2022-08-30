const Content = require('../controllers/content');
const Img = require('../controllers/img');
const api = require('express').Router();

// img
api.get('/img/:name', Img.getImage)

// content
api.get('/content', Content.getContent)

module.exports = api