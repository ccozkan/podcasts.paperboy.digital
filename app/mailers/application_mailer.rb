class ApplicationMailer < ActionMailer::Base
  default from: "PaperboyDigital <no-reply@podcasts.paperboy.digital>"
  default reply_to: "PaperboyDigital <hey@paperboy.digital>"
  layout 'mailer'
end

