class SimpleEmail
  include ActiveModel::Model

  attr_accessor :from, :subject, :body

  validates_presence_of :from
  validates_format_of :from, with: Devise.email_regexp

  validates_presence_of :subject
  validates_length_of :subject, minimum: 3, maximum: 50

  validates_presence_of :body
  validates_length_of :body, minimum: 3, maximum: 500

  def initialize(param)
    @from = param[:from]
    @subject = param[:subject]
    @body = param[:body]
  end

  def formatted
    { 'subject': @subject,
      'body': @body,
      'from': @from }.to_json
  end

  def self.send_email(feedback)
    SimpleMailer.feedback(feedback).deliver_later
  end
end
