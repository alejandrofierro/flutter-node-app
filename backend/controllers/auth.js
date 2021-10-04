const { response } = require("express");
const { generateToken } = require("../helpers/generateToken");


const login = async (req, res = response) => {

    const { username, password } = req.body;
    const userId = process.env.USER_ID;

    try {
        //Verify data
        if (username != process.env.USER || password != process.env.PASS) {
            return res.status(400).json({
                msg: 'Invalid Credentials'
            })
        }

        //JWT 
        const token = await generateToken(userId);



        res.json({
            username,
            token
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            msg: 'Error, please contact the administrator'
        })
    }



}

module.exports = {
    login
}