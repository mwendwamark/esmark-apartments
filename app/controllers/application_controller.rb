class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  before_action :authorize

  def hello_world
    session[:count] = (session[:count] || 0) + 1
    render json: { count: session[:count] }
  end

  def authorize
    current_user = User.find_by(id: session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless current_user
  end

  private

  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.records.errors.full_messages }, status: :unprocessable_entity
  end
end
