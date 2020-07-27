ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail',
  domain: 'gmail.com',
  port: 587,
  user_name: 'my_email',
  password: 'my_password',
  authentication: 'plain',
  enable_starttls_auto: true
}