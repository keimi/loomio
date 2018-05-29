BaseModel = require 'shared/record_store/base_model.coffee'

module.exports = class RegistrationModel extends BaseModel
  @singular: 'registration'
  @plural: 'registrations'
  @serializableAttributes: ['name', 'email', 'isRd', 'rut', 'password', 'passwordConfirmation', 'recaptcha']
  @serializationRoot: 'user'
