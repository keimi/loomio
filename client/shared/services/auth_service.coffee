AppConfig = require 'shared/services/app_config.coffee'
Records   = require 'shared/services/records.coffee'

{ hardReload } = require 'shared/helpers/window.coffee'

module.exports = new class AuthService

  emailStatus: (user) ->
    pendingToken = (AppConfig.pendingIdentity or {}).token
    Records.users.emailStatus(user.email, pendingToken).then (data) =>
      @applyEmailStatus(user, _.first(data.users))

  applyEmailStatus: (user, data = {}) ->
    keys = ['name', 'email', 'avatar_kind', 'avatar_initials', 'gravatar_md5', 'avatar_url', 'has_password', 'email_status']
    user.update _.pick(_.mapKeys(_.pick(data, keys), (v,k) -> _.camelCase(k)), _.identity)
    user.update(hasToken: data.has_token)
    user

  signIn: (user = {}) ->
    Records.sessions.build(email: user.email, password: user.password).save()

  signUp: (user) ->
    Records.registrations.build(email: user.email, name: user.name, isRd: user.isRd, rut: user.rut, recaptcha: user.recaptcha).save().then ->
      if user.hasToken
        hardReload()
      else
        user.sentLoginLink = true

  confirmOauth: ->
    Records.registrations.remote.post('oauth')

  sendLoginLink: (user) ->
    Records.loginTokens.fetchToken(user.email).then ->
      user.sentLoginLink = true
