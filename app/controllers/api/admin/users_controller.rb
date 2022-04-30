class Api::V1::UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  def index
    require_ability!('ADMIN')

    users = User.all
    render json: users, status: :ok
  end

  def show
    require_ability!('ADMIN')
    render json: @user, status: :ok
  end

  def create
    require_ability!('ADMIN')

    user = User.new(user_params)
    if user.save
      render json: {}, status: :ok
    else
      render json: { errors: ['Internal server error. Unable to create a user.'] }, status: :internal_server_error
    end
  end

  def update
    require_ability!('ADMIN')

    if @user.update(user_params)
      render json: {}, status: :ok
    else
      render json: { errors: ['Internal server error. Unable to save current user.'] }, status: :internal_server_error
    end
  end

  def destroy
    require_ability!('MANAGE_USERS_CREATE')
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by(username: user_params[:username])
    render json: { errors: 'User not found' }, status: :not_found unless @user
  end

  def user_params
    params.permit(
        :id, :name, :username, :email, :type, :password, :password_confirmation
    )
  end
end
