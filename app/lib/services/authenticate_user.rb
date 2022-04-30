require 'json_web_token'

module Services
  class AuthenticateUser < Base
    def call
      user = User.find_by(email: context.email)
      if user&.authenticate(context.password)
        context.user = user.username
        context.token = JsonWebToken.encode(user_id: user.id)
      else
        context.fail!(message: "authenticate_user.failure")
      end
    end
  end
end
