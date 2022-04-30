class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    context = Services::AuthenticateUser.call(email: login_params[:email], password: login_params[:password])
    if context.message.present?
      render json: { error: context.message }, status: :unauthorized
    else
      time = Time.now + 24.hours.to_i
      render json: { token: context.token, exp: time.strftime("%m-%d-%Y %H:%M"), username: context.username }, status: :ok
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
