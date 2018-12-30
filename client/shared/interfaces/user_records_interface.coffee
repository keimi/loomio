BaseRecordsInterface = require 'shared/record_store/base_records_interface.coffee'
UserModel            = require 'shared/models/user_model.coffee'
request              = require 'request'
Records              = require 'shared/services/records.coffee'


module.exports = class UserRecordsInterface extends BaseRecordsInterface
  model: UserModel

  updateProfile: (user) =>
    @remote.post 'update_profile', _.merge(user.serialize(), {unsubscribe_token: user.unsubscribeToken })

  uploadAvatar: (file) =>
    @remote.upload 'upload_avatar', file

  changePassword: (user) =>
    @remote.post 'change_password', user.serialize()

  deactivate: (user) =>
    @remote.post 'deactivate', user.serialize()

  saveExperience: (experience) =>
    @remote.post 'save_experience', experience: experience

  updateUser: (user) =>
    @remote.post 'update_profile', user.serialize()

  updateMilitancy: (user) =>
    rem = @remote

    if user.rut != '' && user.number != ''
      request.get {uri:'https://api.revoluciondemocratica.cl/verify?rut=' + user.rut + '&number=' + user.number + '&padron=servel', json : true},
      (err, r, body) ->
        console.log(body)
        if body.status == 'fail'
          user.rut = ''
          user.isRd = false
          rem.post 'update_profile', user.serialize()
        else
          user.isRd = body.padron
          user.rut = body.rut
          rem.post 'update_profile', user.serialize()
    else
      console.log('hola')
    user.rut = ''
    @remote.post 'update_profile', user.serialize()


  emailStatus: (email, token) ->
    @fetch
      path: 'email_status'
      params: _.pick {email: email, token: token}, _.identity
