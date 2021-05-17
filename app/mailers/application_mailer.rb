class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@podcasts.paperboy.digital'
  layout 'mailer'
end

