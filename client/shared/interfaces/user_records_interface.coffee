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

#   request.get {uri:'http://tribunalsupremo.revoluciondemocratica.cl:3000/users?rut=16653056-3&number=109571213', json : true}, (err, r, body) ->
    if user.rut != '' && user.number != ''
      request.get {uri:'http://tribunalsupremo.revoluciondemocratica.cl:3000/verify?rut=' + user.rut + '&number=' + user.number, json : true},
      (err, r, body) ->
#        console.log(body.status)
        if body.status == 'fail'
#          console.log 'request failed'
          user.isRd = false
          rem.post 'update_profile', user.serialize()
        else
#          console.log 'request success'
          user.isRd = true
          rem.post 'update_profile', user.serialize()
    else
#      console.log('no changes')
    @remote.post 'update_profile', user.serialize()


  emailStatus: (email, token) ->
    @fetch
      path: 'email_status'
      params: _.pick {email: email, token: token}, _.identity