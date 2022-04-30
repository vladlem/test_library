module Services
  class UserSearch < Base
    def call
      user = if context.id.present?
        User.find_by(id: context.id)
      elsif conext.username.present?
        User.where(username: conext.username)
      elsif find_by.email.present?
        User.find_by(email: conext.email)
      else
        #TODO need refactoring
        User.where('1 = 0')
      end

      if user.present?
        context.user = user
      else
        context.fail!(message: "User is not found")
      end
    end
  end
end