class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: t("errors.access_denied")
      end
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html do
        redirect_to root_path, alert: t("errors.record_notfound")
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    devise_parameter_sanitizer.permit(:account_update,keys: [:name, :avatar])
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
