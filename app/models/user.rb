class User < ApplicationRecord
  rolify

  after_create :assign_default_role

  has_many :advertisements, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
  end

end
