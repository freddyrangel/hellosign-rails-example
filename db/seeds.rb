admin = User.new email: 'admin@example.com',
  name: 'Admin User',
  phone_number: '555-555-5555',
  password: 'password',
  password_confirmation: 'password'
admin.save
