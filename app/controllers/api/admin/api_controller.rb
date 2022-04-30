class Api::Admin::ApiController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :authorize_admin, except: :create

  def authorize_admin
    raise Pundit::NotAuthorizedError unless @current_user.is_admin?
  end
end