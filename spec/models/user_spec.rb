require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations user creation' do
    it 'should return true if the user do not have a name' do
      utester = User.create(email: "tester.com", encrypted_password: "justesting")
      expect(utester).to_not be_valid
    end
  end

  describe 'add favorites' do 
    let 'return true if the the method is working properly' do #this case is for the first favorite added
      utester = create(:user, active: true, admin: true)
      tester = create(:title)
      utester.add_fav(tester.id)
      result = JSON.parse(utester.favorites)
      expect(result["#{tester.genre}"]).to include(tester.id)
    end
    it 'return true if the second favorite is added when it is a different genre' do #this case when adding a new genre to favorites
      utester = create(:user, active: true, admin: true)
      tester = create(:title)
      utester.add_fav(tester.id)
      result = JSON.parse(utester.favorites)
      expect(result["#{tester.genre}"]).to include(tester.id)
      tester2 = create(:title, genre: "thriller")
      utester.add_fav(tester2.id)
      result = JSON.parse(utester.favorites)
      expect(result["#{tester2.genre}"]).to include(tester2.id)
    end
  end
  describe 'deleting a favorite' do
    it 'return true if the method removed the title from favorites sucessfully' do
      utester = create(:user, active: true, admin: true)
      tester = create(:title)
      utester.add_fav(tester.id)
      result = JSON.parse(utester.favorites)
      expect(result["#{tester.genre}"]).to include(tester.id)
      utester.removefav(tester.id)
      result = JSON.parse(utester.favorites)
      expect(result["#{tester.genre}"]).to_not include(tester.id)
    end
  end

  describe 'payments and check active' do
    it 'returns true if checkactive method is working when the last_payment is nil' do
      utester = create(:user, admin: false, active: nil)
      utester.checkactive
      utester.reload
      expect(utester.active).to be false
    end
    it 'should return true if the checkactive method is working when the last_payment is present and is less ou equal than 30 days' do
      utester = create(:user, admin: false, active: nil)
      utester.startpayment
      utester.reload
      utester.checkactive
      expect(utester.active).to be true
    end
    it 'should return true if the checkactive method is working when the last_payment is present and is past 30 days period.' do
      utester = create(:user, admin: false, active: nil)
      datebackwards = {"last_payment": DateTime.now-35.days}
      utester.personal_information = JSON.generate(datebackwards)
      utester.checkactive
      utester.reload
      expect(utester.active).to be false
    end
  end
end
