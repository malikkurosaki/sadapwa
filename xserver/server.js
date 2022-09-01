const { app, PORT } = require('./server_util.js')
const ip = require('ip');
app.listen(PORT, x => console.log(`Server is running http://${ip.address()}:${PORT} `));