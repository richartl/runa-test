class User < ApplicationRecord
  rolify

  ADMIN_ROLE = 'admin'
  EMPLOYEE_ROLE = 'employee'

  has_many :employee_checks, class_name: 'UserLog', foreign_key: 'admin_id'
  has_many :logs, class_name: 'UserLog', foreign_key: 'employee_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def user_logs
    all_logs = UserLog.none
    if has_role?(User::ADMIN_ROLE)
      all_logs = employee_checks
    end
    if has_role?(User::EMPLOYEE_ROLE)
      all_logs = logs
    end
    all_logs
  end

  def self.find_by_id_for_api(user_id)
    user = User.find_by(id: user_id)
    fail Api::V1::RequestError.new(404, 'User not found') if user.nil?
    user
  end
end
