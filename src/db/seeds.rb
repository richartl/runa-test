in_name = 'in'
UserLogType.create(name: in_name, description: 'Entrada') if UserLogType.find_by(name: in_name).nil?
out_name = 'out'
UserLogType.create(name: out_name, description: 'Salida') if UserLogType.find_by(name: out_name).nil?

admin_email = 'admin@runa.test'
admin = User.create(email: admin_email, password: '12345678') if User.find_by(email: admin_email).nil?
admin.add_role(User::ADMIN_ROLE.to_sym) unless admin.nil?

employee_email = 'employee@runa.test'
employee = User.create(email: employee_email, password: '12345678') if User.find_by(email: employee_email).nil?
employee.add_role(User::EMPLOYEE_ROLE.to_sym) unless employee.nil?
