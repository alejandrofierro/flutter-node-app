const { response } = require('express');
const { Customer } = require('../models/customer');

const getCustomers = async (req, res = response) => {

    const customers = await Customer.findAll();

    res.json({ customers });
}

const getCustomer = async (req, res) => {
    const { id } = req.params;
    const customer = await Customer.findByPk(id);
    if (!customer) {
        return res.status(404).json({
            msg: 'Customer does not exists'
        });
    }

    res.json({
        customer
    })

}

const postCustomer = async (req, res) => {
    const { body } = req;

    try {
        const emailValidator = await Customer.findOne({
            where: {
                email: body.email
            }
        });

        if (emailValidator) {
            return res.status(400).json({
                msg: 'Email already exists :' + body.email
            });
        }

        const customer = new Customer(body);
        await customer.save();
        res.json(customer);

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Please, contact the administrator'
        })
    }

}

const putCustomer = async (req, res) => {
    const { id } = req.params;
    const { body } = req;

    try {
        const customer = await Customer.findByPk(id);
        if (!customer) {
            return res.status(404).json({
                msg: 'Customer does not exists'
            });
        }

        const emailValidator = await Customer.findOne({
            where: {
                email: body.email
            }
        });

        if (emailValidator.email != customer.email) {
            return res.status(400).json({
                msg: 'Email already exists :' + body.email
            });
        }
        await customer.update(body);
        res.json(customer.id);


    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Please, contact the administrator'
        })
    }

}


const deleteCustomer = async (req, res) => {
    const { id } = req.params;
    const customer = await Customer.findByPk(id);
    if (!customer) {
        return res.status(404).json({
            msg: 'Customer does not exists'
        });
    }

    await customer.destroy();
    res.json({ customer })

}



module.exports = {
    getCustomers,
    getCustomer,
    postCustomer,
    putCustomer,
    deleteCustomer
}