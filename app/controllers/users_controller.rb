class UsersController < ApplicationController
  skip_before_action :authorize #,only: [:create, :show,:index ]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    render json: user, status: :accepted
  end

  def show
    render json: @current_user
  end

  private

  def user_params
    params.permit(:name, :email, :house_number, :password, :password_confirmation)
  end

  def render_not_found_response
    render json: { errors: ["User Not Found"] }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
