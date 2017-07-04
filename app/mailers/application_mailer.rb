class ApplicationMailer < ActionMailer::Base
  default from: 'Welcome to Google <recluters@google.com>'
  layout 'mailer'
end
