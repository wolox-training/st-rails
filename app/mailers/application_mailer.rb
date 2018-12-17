class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.email_sender
  layout 'mailer'
end
