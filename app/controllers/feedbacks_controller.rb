class FeedbacksController < ApplicationController
  def new; end

  def create
    email = SimpleEmail.new(permitted_params)
    if email.valid?
      SimpleEmail.send_email(email.formatted)
      redirect_to contact_me_path, notice: "thanks for the feedback:)"
    else
      redirect_to contact_me_path, alert: email.errors.first.full_message
    end
  end

  private

  def permitted_params
    params.permit(:from, :subject, :body)
  end
end
