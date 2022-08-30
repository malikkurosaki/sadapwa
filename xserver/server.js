const express = require('express');
const app = express();
const PORT = process.env.PORT || 3002;
const cors = require('cors');
const api = require('./apis/api');
const ip = require('ip');

app.use(cors())
app.use(express.json());
app.use(express.urlencoded({ extended: true }))
app.use(api)

app.listen(PORT, x => console.log(`Server is running http://${ip.address()}:${PORT} `));