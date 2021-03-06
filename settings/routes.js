'use strict'

module.exports = (app) => {

    const numbersController = require('../controller/numbersController')

    app.route(`/startNumber/:data`).post(numbersController.startNumber)
    app.route('/getLocation').get(numbersController.getLocation)
    app.route('/getlpu').get(numbersController.getLPU)
    app.route('/getalllocations').get(numbersController.getAllLocations)
    app.route('/postnewlocation/:data').post(numbersController.putNewLocation)
    app.route('/deletelocation/:id').delete(numbersController.deleteLocation)
    app.route('/locationcopycount/:id').get(numbersController.getLocationCopyCount)
    app.route('/getcopycountforlocation/:id').get(numbersController.getCopyCountForLocation)
    app.route('/getfilteredlocations/:selectedLPU').get(numbersController.getFilteredLocations)
    //app.route('/getuseraccess/:id').get(numbersController.getUserAccess)            //получает права доступа пользователя к модулям
}