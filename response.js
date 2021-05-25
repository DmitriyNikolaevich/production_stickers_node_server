'use strict'

exports.status = (values, res) => {

    let data = {
        "status": 200,
        "values": values
    }

    res.json(data)
    res.end()
}