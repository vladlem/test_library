class Api::Admin::UsersController < Api::Admin::ApiController
  before_action :find_user, except: %i[create index update]

  def index
    users = User.select(:username, :email, :user_type).all
    render json: users, status: :ok
  end

  def show
    if @reult.message.present?
      render json: { errors: @result.message }, status: :not_found
    else
      render json: @result.user, status: :ok
    end
  end

  def create
    result = Services::UserCreate.call(
      username: user_params[:username],
      email: user_params[:email],
      user_type: user_params[:user_type],
      password: user_params[:password],
      password_confirmation: user_params[:password_confirmation]
    )
    if result.message.present?
      render json: { errors: result.message }, status: :not_found
    else
      render json: result.user, status: :ok
    end
  end

  def update
    result = Services::UserSearch.call(
      user_type: user_params[:user_type],
      username: user_params[:username],
      email: user_params[:email],
      password: user_params[:password]
    )
    if result.message.present?
      render json: { errors: result.message }, status: :not_found
    else
      render json: result.user, status: :ok
    end
  end

  def destroy
    user = @result.user
    user.destroy
  end

  private

  def find_user
    @result = Services::UserSearch.call(id: user_params[:id], username: user_params[:username], email: user_params[:email])
  end

  def user_params
    params.permit(:id, :username, :email, :user_type, :password, :password_confirmation)
  end
end
