
const express = require("express");
const app = express();
const PORT = process.env.PORT || 3002;
const cors = require('cors');
const api = require('./apis/api');

app.use(cors())
app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use(api)

app.use((req, res, next) => {
    res.status(404).send("404");
})

app.use((req, res, next) => {
    res.status(500).send("500");
})

module.exports = { app, PORT };
