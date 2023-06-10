module DeviseTweakable
  extend ActiveSupport::Concern

  included do
    validates_presence_of   :email, if: :email_required?
    validates_format_of     :email, with: Devise.email_regexp
    validates_presence_of     :password, if: :password_required?
    validates_confirmation_of :password, if: :password_required?
    validates_uniqueness_of :email, allow_blank: true, case_sensitive: true, scope: :provider
    validates_format_of     :email, with: Devise.email_regexp, allow_blank: true
    validates_uniqueness_of :email, scope: :provider
  end

  def email_required?
    true
  end

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
