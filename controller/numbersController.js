'use strict'

const response = require('../response')
const db =require('../settings/db')

exports.startNumber = (req, res) => {

    const data = JSON.parse(req.params.data)
    
    const sql = `CALL create_number_for_stickers(${data.id}, ${data.copy})`

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

};

exports.getLocation = (req, res) => {

    const id = isNaN(req.query.id) ? 1 : req.query.id

    const sql = `CALL get_location(${id})`

    db.query(sql, (error, rows, fields) => {

        if (error) {
            console.log(`Curent number select ERROR ${error}`)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

}

exports.getLPU = (req, res) => {

    const sql = 'CALL get_lpu()'

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')
}

exports.getAllLocations = (req, res) => {
    const sql = 'CALL get_all_locations()'

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

}

exports.putNewLocation = (req, res) => {

    const data = JSON.parse(req.params.data)

    const sql = `CALL insert_new_location(${data.lpu}, '${data.location}')`

    db.query(sql, (error, rows, fields) => {

        if (error) {
            console.log(`Curent number select ERROR ${error}`)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

}

exports.deleteLocation = (req, res) => {

    const id = Number(req.params.id)

    const sql = `DELETE FROM locations WHERE id = ${id}`

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })
    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

}

exports.getLocationCopyCount = (req, res) => {
    const data = JSON.parse(req.params.id)
    
    const sql = `CALL get_location_copy_count(${data.copyCount}, ${data.location})`

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')
}

exports.getCopyCountForLocation = (req, res) => {

    const data = Number(req.params.id)

    const sql = `SELECT copy FROM locations WHERE id = ${data}`
    
    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')
}

exports.getFilteredLocations = (req,res) => {

    const data = Number(req.params.selectedLPU)

    const sql = `CALL get_filtered_locations(${data})`

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')
    
}

exports.getUserBatchAccess = (req, res) => {
    
    const sql = `SELECT batchAccess FROM locations WHERE id = ${req.params.id}`

    db.query(sql, (error, rows, fields) => {
        if (error) {
            console.log(error)
        } else {
            response.status(rows, res)
        }
    })

    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Headers', 'origin, content-type, accept')

}