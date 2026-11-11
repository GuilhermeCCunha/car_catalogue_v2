class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role

  def dashboard
  end

  private

  def check_admin_role
    redirect_to root_path, alert: t('.access_denied') unless current_user.admin?
  end
end
