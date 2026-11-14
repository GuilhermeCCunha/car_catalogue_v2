class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_role
  before_action :set_user, only: [:ban_user, :unban_user]

  def dashboard
    @users = User.where.not(role: :admin)
  end

  def ban_user
    if @user.lock_access!
      redirect_to admin_dashboard_path, notice: t('.notice', email: @user.email)
    else
      redirect_to admin_dashboard_path, alert: t('.alert')
    end
  end

  def unban_user
    @user.unlock_access!
    redirect_to admin_dashboard_path, notice: t('.notice', email: @user.email)
  end

  private

  def check_admin_role
    redirect_to root_path, alert: t('.access_denied') unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end
end
