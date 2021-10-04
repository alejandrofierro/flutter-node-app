const { response, request } = require('express')
const jwt = require('jsonwebtoken')

const jwtValidation = (req = request, res = response, next) => {

    const token = req.header('token-key');
    if (!token) {
        res.status(401).json({
            msg: 'no valid token'
        })
    }

    try {


        const { uid } = jwt.verify(token, process.env.SECRETORPRIVATEKEY);
        req.uid = uid;



        next();
    } catch (error) {
        console.log(error);
        res.status(401).json({
            msg: 'no valid token'
        })
    }


}

module.exports = {
    jwtValidation
}