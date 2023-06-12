class SimpleMailer < ApplicationMailer
  def feedback(feedback)
    feedback = JSON.parse(feedback)

    @from = feedback["from"]
    @subject = feedback["subject"]
    @body = feedback["body"]
    to_email = ENV["FEEDBACK_RECEIVER_EMAIL"]

    mail(to: to_email, subject: "Feedback for podcasts.paperboy.digital")
  end
end
