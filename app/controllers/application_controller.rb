class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
    render json: { message: "This is an Address Book created to test my skills in RoR, enjoy it!" }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :organizations_ids])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :organizations_ids])
  end
end
