class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    requested_locale = params[:locale]
    matched_locale = locale_valid?(requested_locale) if requested_locale.present?

    cookies[:locale] = matched_locale.to_s if matched_locale

    I18n.locale = extract_locale
  end

  private

  def extract_locale
    current_cookie = cookies[:locale]
    matched_locale = locale_valid?(current_cookie) if current_cookie.present?

    matched_locale || I18n.default_locale
  end

  def locale_valid?(locale)
    I18n.available_locales.find { |l| l.to_s.casecmp?(locale.to_s) }
  end
end
