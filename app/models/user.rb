class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable

  enum role: { regular: 0, admin: 1 }

  before_create :set_admin

  def lock_access!(opts = { })
    return false if self.admin?
    super
  end

  private
    def set_admin
      self.role = :admin unless User.exists?
    end
end
