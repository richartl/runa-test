require 'rails_helper'

RSpec.describe UserLog, type: :model do
  describe 'associations' do
    it { should belong_to(:employee).class_name('User') }
    it { should belong_to(:admin).class_name('User') }
    it { should belong_to(:user_log_type).class_name('UserLogType') }
  end
end
