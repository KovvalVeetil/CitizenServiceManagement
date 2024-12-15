class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  ROLES = %w[citizen admin department_user].freeze 

  validates :role, inclusion: { in:ROLES }

  def citizen?
    role == 'citizen'
  end

  def admin?
    role == 'admin'
  end

  def department_user?
    role == 'department_user'
  end
end
