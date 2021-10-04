const express = require('express');
const db = require('./database');

class Server {
    constructor() {
        this.app = express();
        this.port = process.env.PORT || 8080;
        this.app.use(express.json());
        this.customerPath = '/api/customers';
        this.authPath = '/api/auth';

        //Database
        this.dbConnect();

        //Middlewares

        //Routes
        this.routes();
    }

    async dbConnect() {
        try {
            await db.authenticate();
            await db.sync();
            console.log('Database On')
        } catch (error) {
            throw new Error(error);
        }
    }


    middlewares() {

    }


    routes() {
        this.app.use(this.authPath, require('../routes/auth'));
        this.app.use(this.customerPath, require('../routes/customers'));
    }

    listen() {
        this.app.listen(this.port, () => {
            console.log('Server Running :', this.port);
        })
    }

}

module.exports = Server;