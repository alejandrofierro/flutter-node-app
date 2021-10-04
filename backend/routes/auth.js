const { Router } = require('express');
const { check } = require('express-validator');
const { login } = require('../controllers/auth');
const { fieldValidation } = require('../middlewares/fieldValidation');


const router = Router();

router.post('/login', [
    check('username', 'The user is required').not().isEmpty(),
    check('password', 'The password is required').not().isEmpty(),
    fieldValidation
], login);




module.exports = router;