require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations user creation' do
    it 'should return true if the user do not have a name' do
      utester = User.create(email: "tester.com", encrypted_password: "justesting")
      expect(utester).to_not be_valid
    end
  end

end
