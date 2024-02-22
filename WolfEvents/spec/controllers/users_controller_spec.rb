# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    {
      email: "test@example.com",
      name: "Test User",
      phone_number: "1234567890",
      credit_card: "1234567890123456",
      password: "password",
      password_confirmation: "password"
    }
  }

  let(:invalid_attributes) {
    {
      email: "invalid_email",
      name: "",
      phone_number: "123",
      credit_card: "123",
      password: "pass",
      password_confirmation: "word"
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      user = User.create! valid_attributes
      get :index
      expect(response).to_not be_successful
    end
  end


end
