# frozen_string_literal: true

class User < ApplicationRecord
  rolify

  after_create :assign_default_role

  has_many :advertisements, dependent: :destroy

  validates :username, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    has_role?(:admin)
  end

  def user?
    has_role?(:user)
  end

  def assign_default_role
    add_role(:user) if roles.blank?
  end
end
