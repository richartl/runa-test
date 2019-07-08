class UserLog < ApplicationRecord
  belongs_to :admin, class_name: 'User'
  belongs_to :employee, class_name: 'User'
  belongs_to :user_log_type, class_name: 'UserLogType'
end
