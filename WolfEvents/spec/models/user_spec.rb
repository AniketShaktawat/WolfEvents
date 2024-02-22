require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without an email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a phone number' do
    user = User.new(phone_number: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a credit card' do
    user = User.new(credit_card: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without a password digest' do
    user = User.new(password_digest: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid with a duplicate email' do
    existing_user = create(:user, email: 'test@example.com')
    user = User.new(email: 'test@example.com')
    expect(user).to_not be_valid
  end

  it 'is invalid with an invalid email format' do
    user = User.new(email: 'invalidemail.com')
    expect(user).to_not be_valid
  end

  it 'is invalid with a phone number not exactly 10 digits long' do
    user = User.new(phone_number: '123456789')
    expect(user).to_not be_valid
  end

  it 'is invalid with a credit card not exactly 16 digits long' do
    user = User.new(credit_card: '123456789012345')
    expect(user).to_not be_valid
  end
end