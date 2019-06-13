class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name)
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options options = {}
    {locale: I18n.locale}.merge options
  end

  def authenticate_administrator
    return true if current_user&.admin?
    flash[:error] = t(".access_denied")
    redirect_to root_path
  end
end
