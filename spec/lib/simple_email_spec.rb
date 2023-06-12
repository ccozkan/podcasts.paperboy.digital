require "rails_helper"
 
RSpec.describe SimpleEmail, type: :model do
  let(:subject) { SimpleEmail.new( {'title': 'title', 'subject': 'subject', 'from': 'feedbacker@helloword.com' } ) }

  describe "validations" do
    it do
      expect(subject).to validate_presence_of(:from)
      expect(subject).to validate_presence_of(:subject)
      expect(subject).to validate_presence_of(:body)
    end
  end
end
