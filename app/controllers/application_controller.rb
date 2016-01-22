class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  rescue_from PaymentService::PaymentServiceError, with: :handle_payment_service_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
  end

  def handle_payment_service_error(exception)
    flash[:alert] = "There was a problem connecting with the payment service (#{exception.message}).  Please try again later."
    redirect_to dashboard_index_path
  end

end
