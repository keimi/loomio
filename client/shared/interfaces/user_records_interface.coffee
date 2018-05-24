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

  updateMilitancy: (user) =>
    console.log(user.rut)
    console.log(user.number)
    rem = @remote

    if user.rut != '' && user.number != ''
      request.get {uri:'http://tribunalsupremo.revoluciondemocratica.cl:3000/verify?rut=' + user.rut + '&number=' + user.number, json : true},
      (err, r, body) ->
        if body.status == 'fail'
          user.isRd = false
          rem.post 'update_profile', user.serialize()
        else
          user.isRd = true
          rem.post 'update_profile', user.serialize()
    else
    @remote.post 'update_profile', user.serialize()


  emailStatus: (email, token) ->
    @fetch
      path: 'email_status'
      params: _.pick {email: email, token: token}, _.identity