module Services
  class UserCreate < Base
    def call
      user = User.create!({
        username: context.username,
        email: context.email,
        user_type: context.user_type,
        password: context.password,
        password_confirmation: context.password_confirmation
      })
      context.user = user
    rescue => e
      context.fail!(message: e.message)
    end
  end
end
