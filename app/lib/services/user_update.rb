module Services
  class UserUpdate < Base
    def call
      result = Services::UserSearch.call(id: context.id)
      return context.fail!(message: result.message) if result.message.present?

      user = result.user
      if user.update({ email: context.email, username: context.username, user_type: context.user_type, password: context.password })
        context.user = user
      else
        context.fail!(message: "User is not updated")
      end
    end
  end
end
