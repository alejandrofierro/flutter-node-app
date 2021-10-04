
const { Router } = require('express');
const { getCustomers, getCustomer, postCustomer, putCustomer, deleteCustomer } = require('../controllers/customers');
const { jwtValidation } = require('../middlewares/jwtValidation');

const router = Router();


router.get('/', [jwtValidation], getCustomers);
router.get('/:id', [jwtValidation], getCustomer);
router.post('/', [jwtValidation], postCustomer);
router.put('/:id', [jwtValidation], putCustomer);
router.delete('/:id', [
    jwtValidation,
], deleteCustomer);




module.exports = router;