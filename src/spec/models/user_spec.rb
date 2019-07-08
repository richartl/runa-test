require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:employee_checks).class_name('UserLog').with_foreign_key('admin_id') }
  it { should have_many(:logs).class_name('UserLog').with_foreign_key('employee_id') }
end
