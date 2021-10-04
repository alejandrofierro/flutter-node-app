require('dotenv').config();
const Server = require('./models/server');


//Server init
const server = new Server();
server.listen();

