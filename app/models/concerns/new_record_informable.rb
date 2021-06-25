module NewRecordInformable
  extend ActiveSupport::Concern

  included do
    after_create_commit :inform_via_honeybadger
  end

  def inform_via_honeybadger
    Honeybadger.notify("🎉 New #{self.class.name} 🎉")
  end
end
